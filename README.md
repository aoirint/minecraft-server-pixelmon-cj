# minecraft-server-pixelmon-cj

Pixelmon ModPackを導入した身内向けサーバインスタンス。

## サーバー側構成

- Minecraft 1.12.2
- Minecraft Forge
- (CurseForge) The Pixelmon Modpack: <https://www.curseforge.com/minecraft/modpacks/the-pixelmon-modpack>
- Dynmap Forge

## クライアント環境構築

環境の同期のため、CurseForgeを使用してクライアント環境を構築することを推奨。

- <https://download.curseforge.com/>

CurseForge Appインストール後、CurseForge Appから以下のMod Packを検索してインストール。

- <https://www.curseforge.com/minecraft/modpacks/the-pixelmon-modpack>

## 新規稼働

TBW

## サーバコンソール

コンテナ名を調べる。

```shell
docker compose ps
```

コンテナにアタッチする。標準入力でコマンドが利用できる。`Ctrl+P Ctrl+Q`でサーバを停止せずデタッチする。

```shell
docker attach <container_name>
```
