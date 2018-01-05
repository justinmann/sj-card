console.writeLine("hello world")

#writer(
    write2(s : 'string)'void
)

consoleWriter #writer(
    write2(s : 'string) {
        console.write(s)
        void
    }
) { this }

hypertext(
    writer : 'heap #writer

    tag(childTagName : 'string, attrs : empty'hash![string, string], cb : empty'(:hypertext)void) {
        writer.write2("<")
        writer.write2(childTagName)
        ifValid attrs {
            attrs.each(^{
                writer.write2(" ")
                writer.write2(_1)
                writer.write2("=\"")
                writer.write2(_2)
                writer.write2("\"")
            })
        }
        writer.write2(">")

        ifValid cb {
            cb(parent)
        }

        writer.write2("</")
        writer.write2(childTagName)
        writer.write2(">")
    }
) { this }

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