# Roblox Fake Item Injection Research

Simple research project tentang bagaimana fake item injection dapat terjadi pada game Roblox jika server terlalu percaya kepada client.

Project ini dibuat untuk menunjukkan pentingnya:
- server-side validation
- sanity checking
- dan secure backend structure

---

# What is Fake Item Injection?

Fake Item Injection adalah exploit dimana client mencoba mengirim item palsu ke server menggunakan RemoteEvent atau RemoteFunction.

Contoh:
```lua
RemoteEvent:FireServer("SwordAdmin", 999999)
```

Jika server tidak melakukan validasi:
- item ilegal bisa masuk inventory
- economy game bisa rusak
- trading system dapat disalahgunakan
- datastore dapat terkontaminasi item palsu

---

# Philosophy

> Never Trust The Client

Client Roblox dapat dimodifikasi menggunakan exploit tools, sehingga server tidak boleh langsung percaya terhadap:
- nama item
- jumlah item
- request inventory
- trade data

Semua data harus divalidasi dari sisi server.

---

# Features

✅ Fake Item Detection  
✅ Invalid Amount Validation  
✅ Whitelist Item System  
✅ Server-Side Validation  
✅ Simple Inventory Protection  

---

# Allowed Items

Server hanya menerima item yang sudah terdaftar pada whitelist.

```lua
local AllowedItems = {
    Sword = true,
    Potion = true
}
```

Jika client mencoba mengirim item di luar whitelist:

```lua
RemoteEvent:FireServer("SwordAdmin", 999999)
```

Server akan menolak request tersebut.

---

# RemoteEvent Validation

```lua
remoteEvent.OnServerEvent:Connect(onInventoryItem)
```

Server menerima request dari client kemudian melakukan validasi:
- apakah item valid
- apakah amount valid
- apakah data aman diproses

---

# Fake Item Validation

```lua
if not AllowedItems[item] then
    warn("Invalid Item:", item)
    return
end
```

Penjelasan:
- mengecek apakah item ada di whitelist
- jika tidak ada maka request dianggap ilegal

Contoh:
```lua
SwordAdmin
```

Output:
```lua
Invalid Item: SwordAdmin
```

---

# Amount Validation

```lua
if type(amount) ~= "number" or amount <= 0 then
```

Penjelasan:
- memastikan amount berupa angka
- memastikan jumlah item tidak negatif atau nol

Contoh invalid request:
```lua
RemoteEvent:FireServer("Sword", -999)
```

atau:
```lua
RemoteEvent:FireServer("Sword", "hacked")
```

---

# Inventory System

```lua
PlayerData[player][item] =
    (PlayerData[player][item] or 0) + amount
```

Penjelasan:
- menambahkan item ke inventory player
- menggunakan fallback `or 0`
- menghindari error ketika item belum ada

---

# Example Exploit

## Vulnerable Code

```lua
RemoteEvent.OnServerEvent:Connect(function(player, item, amount)
    player.Inventory[item] =
        (player.Inventory[item] or 0) + amount
end)
```

Masalah:
- server langsung percaya client
- item palsu dapat dikirim
- amount tidak dibatasi

Exploit:
```lua
RemoteEvent:FireServer("AdminSword", 999999)
```

---

# Secure Example

```lua
if not AllowedItems[item] then
    return
end
```

Server hanya menerima item yang valid.

---

# Why This Matters

Banyak exploit Roblox terjadi karena:
- backend tidak aman
- RemoteEvent tidak divalidasi
- client terlalu dipercaya
- tidak ada sanity check

Project ini bertujuan mempelajari dasar secure backend architecture pada Roblox.

---

# Future Research

Project berikutnya:
- Remote Spam Protection
- Anti Duplicate Item
- Trade Validation
- Secure Datastore
- Session Locking
- Server Authoritative Economy
- Remote Cooldown System

---

# Status

🚧 Learning & Research Project  
🔐 Focused on Roblox Backend Security  
🛡️ Focused on Anti Exploit Architecture  

---

# Author

HavocShadow

GitHub:
https://github.com/HavocShadow
