
import 'dart:convert';

List<Link> linkFromJson(String str) => List<Link>.from(json.decode(str).map((x) => Link.fromJson(x)));

String linkToJson(List<Link> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Link {
    String id;
    String name;
    String link;

    Link({
        this.id,
        this.name,
        this.link,
    });

    factory Link.fromJson(Map<String, dynamic> json) => Link(
        id: json["id"],
        name: json["name"],
        link: json["link"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "link": link,
    };
}
