import MeowVapor
import Vapor
import HTTP

let drop = Droplet()

drop.middleware = []

drop.get("authors", User.self) { _, user in
    return user
}

drop.get("authors", User.self, "articles") { request, user in
    return try Article.find { article in
        return article.author == user
    }
}

drop.get("articles", Article.self, "author") { request, article in
    return try article.author.resolve()
}

try! drop.start("mongodb://localhost:27017/databasename")
