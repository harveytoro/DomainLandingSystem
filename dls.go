package main

import (
	"html"
	"html/template"
	"log"
	"net/http"
	"os"

	"github.com/gorilla/mux"
)

type tmplFill struct {
	Title string
}

func main() {
	var port = os.Getenv("dls_port")

	if port == "" {
		port = "3030"
	}

	router := mux.NewRouter()
	router.HandleFunc("/", handleRequest)
	router.NotFoundHandler = http.HandlerFunc(handleRequest)

	http.Handle("/", router)

	http.Handle("/vendor/", http.FileServer(http.Dir("static")))
	http.Handle("/img/", http.FileServer(http.Dir("static")))
	http.Handle("/css/", http.FileServer(http.Dir("static")))

	log.Fatal(http.ListenAndServe(":"+port, nil))
}

func handleRequest(w http.ResponseWriter, r *http.Request) {
	tmpl := template.Must(template.ParseFiles("template/index.html"))
	fill := tmplFill{Title: html.EscapeString(r.Host)}
	tmpl.Execute(w, fill)
}
