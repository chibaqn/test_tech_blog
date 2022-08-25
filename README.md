## GitHub を使った運用を始めるときに 1度だけ実行する

はてなブログに存在する記事を取得する。

[https://github.com/x-motemen/blogsync#エントリーをダウンロードする](https://github.com/x-motemen/blogsync#%E3%82%A8%E3%83%B3%E3%83%88%E3%83%AA%E3%82%92%E3%83%80%E3%82%A6%E3%83%B3%E3%83%AD%E3%83%BC%E3%83%89%E3%81%99%E3%82%8Bblogsync-pull)

※ カスタムURLを指定していても `entries/chibaqn.hatenablog.com/entry/2022/06/15/232422.md` のような日付のパスとなるので注意。

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

## 記事を執筆する流れ

### 1. ローカルの master ブランチを最新の状態にする

※ ローカルにリポジトリが無いときは clone する。

```
$ git checkout master
$ git pull
```

### 2. 新しい下書き記事を追加する

記事執筆用のブランチを作成する。

```bash
$ git checkout -b how-to-push-entry-to-hatenablog
```

下書き記事を生成する。

※ 下記のコマンドを実行すると、はてなブログ 側にも下書き記事が作成される。

| オプション | 必須 かどうか | 説明 |
| --- | --- | --- |
| --draft | 必須 | 下書きモードで作成する |
| --custom-path | 必須 | ファイル名 == URL Slug |

```bash
$ docker-compose run -u "$(id -u):$(id -g)" --rm blogsync post --draft --custom-path=how-to-push-entry-to-hatenablog chibaqn.hatenablog.com < draft.md
      POST ---> https://blog.hatena.ne.jp/chibaqn/chibaqn.hatenablog.com/atom/entry
       201 <--- https://blog.hatena.ne.jp/chibaqn/chibaqn.hatenablog.com/atom/entry
     store entries/chibaqn.hatenablog.com/entry/how-to-push-entry-to-hatenablog.md
```

### 3. Pull Request を作成する

以降、PUSH するたびに、はてなブログ側の下書き記事が更新される。

### 4. 記事を執筆する

front matter を記載する。

[https://github.com/x-motemen/blogsync#ファイルのフォーマット](https://github.com/x-motemen/blogsync#%E3%83%95%E3%82%A1%E3%82%A4%E3%83%AB%E3%81%AE%E3%83%95%E3%82%A9%E3%83%BC%E3%83%9E%E3%83%83%E3%83%88)

※ 値は途中で変更して OK.
```
---
Title: はてなブログに記事をPUSHする方法
Category:
- github
Date: 2022-08-25T23:50:21+09:00
URL: https://chibaqn.hatenablog.com/entry/how-to-push-entry-to-hatenablog
EditURL: https://blog.hatena.ne.jp/chibaqn/chibaqn.hatenablog.com/atom/entry/4207112889911938896
Draft: true
CustomPath: how-to-push-entry-to-hatenablog
---
```

記事の本文を執筆する。

```
---
Title: はてなブログに記事をPUSHする方法
Category:
- github
Date: 2022-08-25T23:50:21+09:00
URL: https://chibaqn.hatenablog.com/entry/how-to-push-entry-to-hatenablog
EditURL: https://blog.hatena.ne.jp/chibaqn/chibaqn.hatenablog.com/atom/entry/4207112889911938896
Draft: true
CustomPath: how-to-push-entry-to-hatenablog
---

本文
```
