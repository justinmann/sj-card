library "release-1.0:https://github.com/justinmann/sj-lib-json.git"

#writer(
    write(s : 'string)'void
)

consoleWriter #writer(
    write(s : 'string) {
        console.write(s)
        void
    }
) { this }

hypertext(
    writer : 'heap #writer

    tag(childTagName : 'string, attrs : empty'hash![string, string], cb : empty'(:hypertext)void) {
        writer.write("<")
        writer.write(childTagName)
        ifValid attrs {
            attrs.each(^{
                writer.write(" ")
                writer.write(_1)
                writer.write("=\"")
                writer.write(_2)
                writer.write("\"")
            })
        }
        writer.write(">")

        ifValid cb {
            cb(parent)
        }

        writer.write("</")
        writer.write(childTagName)
        writer.write(">")
    }
) { this }

text : "{\"project\":\"rapidjson\",\"stars\":10}"
data2 : json.document_load(text)
v : data2["stars"].asi32()
console.writeLine(v.asString())
console.writeLine(data2["project"].asString())

h : hypertext(heap consoleWriter() as #writer)
h.tag("html", { "id" : "12" })
console.writeLine("END")

/*
render(h : 'hypertext, model) {
    h.tag("Section", { "id" : "titleSection", "spacing" : "none" }, ^{
        _.tag("Heading", {id:"title", headingLevel: 1, textSize:"large", spacing:"none", textColor:"secondary"}, ^{
            _.tag("Text", {id:"productTitle", textSize:"large"}).join(" ", function (h) {
                _.raw(model.title)

                if (model.parentalAdvisory) {
                    _.tag("Text", {id:"parentalAdvisory", cssClass:"a-text-normal", textSize:"medium", textColor:"secondary"})
                    _.txt(model.parentalAdvisory)
                }

                if (model.formatList.length > 0) {
                    h("Text", {textSize:"medium", cssClass:"a-text-normal", textColor:"secondary"}).join(", ", function (h) {
                        model.formatList.forEach(function (format) {
                            h.txt(format)
                        })
                    })
                }
            })

            if (model.hasAdultText) {
                h("Text", {textSize:"medium", cssClass:"a-text-normal", textColor:"secondary"})
                    .txt(model.strings.adult_17481)
            }

            if (model.energyEfficiencyClass) {
                h("Text", {id:"energyEfficiencyTitleInformation", textSize:"medium"})
                    .txt("[", model.strings.dp_product_info_energy_class, " ", model.energyEfficiencyClass, "]")
            }
        })

        h("Section", {id:"expandTitleToggle", cssClass:"expandTitleToggle", spacing:"none"})
    })
}
*/