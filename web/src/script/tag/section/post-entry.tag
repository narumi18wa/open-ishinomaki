post-entry
    .form
        input-form-item(title="タイトル" iid="title")
        input-form-pulldown(title="タグ" iid="tag" options="{tagOptions}")
        input-form-pulldown(title="地域" iid="regional" options="{regionalOptions}")
        input-form-pulldown(title="地域区分" iid="subRegional" options="{subRegionalOptions}")
        img#preview
        input-form-item(title="画像" iid="image" type="file")
        input-form-textarea(title="本文" iid="desc")

        button#sendButton(onClick="{onClick}") Post

    script.
        import $ from "jquery"
        import {pajax} from "../../util/PromisedAjax"
        import Base64 from "../../util/Base64"

        // TODO: DBから取ってくる
        this.tagOptions = [
            { name: 'イベント', id: 1 },
            { name: '飲食店', id: 2 },
            { name: 'セール', id: 3 }
        ]
        this.regionalOptions = [
            { name: '山下', id: 1 },
            { name: '西山', id: 2 },
            { name: '田道町', id: 3 },
            { name: '中央', id: 4 }
        ]
        this.subRegionalOptions = [
            { name: '1丁目', id: 1 },
            { name: '2丁目', id: 2 }
        ]

        this.onClick = () => {
            const name = $(".form #title", this.root).val()
            const tag_ids = [Number($(".form #tag").val())]
            const regional_id = Number($(".form #regional").val())
            const sub_regional_id = Number($(".form #subRegional").val())
            const text = $(".form #desc").val()
            let images = [Base64.encodeToBase64Image($(".form img#preview", this.root)[0], "image/jpg")]
            if (images[0] == "data:,") {
                images = null
            }
            pajax("post", "/api/postRegionalEntry", null, {
                name: name,
                tag_ids: tag_ids,
                regional_id: regional_id,
                sub_regional_id: sub_regional_id,
                text: text,
                images: images
            }).then((response) => {
                window.location.href = "/page/search.html"
            })
        }

        this.on("mount", () => {
            const fileinput = $("input-form-item #image", this.root)
            fileinput.change(() => {
                console.log("change")
                const files = fileinput.prop('files')
                const file = files[0]
                const fileRdr = new FileReader()
                const preview = $("img#preview", this.root)

                if (!files.length) {
                    preview.removeAttr("src")
                } else {
                    if (file.type.match('image.*')) {
                        fileRdr.onload = () => {
                            console.log("onload")
                            preview.attr('src', fileRdr.result)
                        }
                        fileRdr.readAsDataURL(file)
                    } else {
                        preview.removeAttr("src")
                    }
                }
            })
        })

    style(type="sass").
        @import "../../../style/color.sass"

        post-entry
            display: block

        img#preview
            width: 90%
            height: auto

        .form
            width: 600px
            margin: 32px auto
            padding: 16px
            background: $color-main-theme
            overflow: hidden

            button#sendButton
                float: right
                margin: 8px
                padding: 8px
                background: white
