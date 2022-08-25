
## 記事を執筆する流れ

### 1. master ブランチを最新化する

```bash
$ docker-compose run -u "$(id -u):$(id -g)" --rm blogsync pull chibaqn.hatenablog.com
       GET ---> https://blog.hatena.ne.jp/chibaqn/chibaqn.hatenablog.com/atom/entry
       200 <--- https://blog.hatena.ne.jp/chibaqn/chibaqn.hatenablog.com/atom/entry
     fresh remote=2022-08-25 22:42:09 +0900 +0900 > local=0001-01-01 00:00:00 +0000 UTC
     store entries/chibaqn.hatenablog.com/entry/2022/08/25/224209.md
     fresh remote=2022-07-26 17:11:29 +0900 +0900 > local=0001-01-01 00:00:00 +0000 UTC
     store entries/chibaqn.hatenablog.com/entry/2022/06/15/233129.md
     fresh remote=2022-07-20 11:50:23 +0900 +0900 > local=0001-01-01 00:00:00 +0000 UTC
     store entries/chibaqn.hatenablog.com/entry/2022/06/15/232422.md
```
### 2. 新しい記事を追加する

記事執筆用のブランチを作成する。

```bash
$ git checkout -b how-to-push-entry-to-hatenablog
```

記事の雛形を生成する。

| オプション | 説明 |
| --- | --- |
| --draft | 下書きモードで作成する |
| --title | ブログのタイトル |
| --custom-path | 記事の URL のパス |

```bash
$ docker-compose run -u "$(id -u):$(id -g)" --rm blogsync post --draft --title=はてなブログに記事をPUSHする方法 --custom-path=how-to-push-entry-to-hatenablog chibaqn.hatenablog.com < draft.md
      POST ---> https://blog.hatena.ne.jp/chibaqn/chibaqn.hatenablog.com/atom/entry
       201 <--- https://blog.hatena.ne.jp/chibaqn/chibaqn.hatenablog.com/atom/entry
     store entries/chibaqn.hatenablog.com/entry/how-to-push-entry-to-hatenablog.md
```
