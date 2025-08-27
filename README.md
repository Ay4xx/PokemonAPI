# Activity6 – Pokedex App

##  What the app does
This app is a simple **Pokédex** built with **SwiftUI** using the MVVM architecture.  
It allows the user to:
- View a **list of Pokémon** with their names and images.
- Tap on a Pokémon to see a **detail view** with more information (name, image, base experience, height, species).

The app includes:
- **Two levels of navigation** (List → Detail).
- **Loading indicators** while fetching data.
- **Error handling** for network issues (offline mode or API errors).
- **Clean Code practices** and concise code documentation.

---

## API 
The app connects to the free **[PokeAPI](https://pokeapi.co/)**.  

Endpoints used:
- **List of Pokémon:**  
  [https://pokeapi.co/api/v2/pokemon?limit=20&offset=0](https://pokeapi.co/api/v2/pokemon?limit=20&offset=0)  
- **Pokémon details:**  
  `https://pokeapi.co/api/v2/pokemon/{id}/` (example: [https://pokeapi.co/api/v2/pokemon/1/](https://pokeapi.co/api/v2/pokemon/1/))

---

## How to run the app

1. Clone or download this repository
