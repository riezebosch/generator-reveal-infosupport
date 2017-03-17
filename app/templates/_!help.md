# Help

--

Voeg slides toe in de `slides` folder*

<small>*Op dit moment aleen markdown.</small>

--

Groepeer modules in subfolders*:

```bash
slides
  + 00-eerste module
  |  + 00-eerste onderwerp.md
  |  + 10-tweede onderwerp.md
  |  + 20-derde onderwerp.md
  + 10-tweede module
  |  + 00-eerste andere ondewerp.md
  |  + 10-tweede andere ondwerp.md
  + 20-derde module
     + 00-enzovoort.md
```

<small>* Werkt niet om combinatie met separators</small>

--

Of maak subsecties met separators:

```md
# Titel

Slide 1

 --

## Iets minder grote titel

Slide 2

 --

## Volgende slide

Slide 3

```

--

Je kunt alles in één grote file stoppen*

```md
# Training

 ---

## Welkom

 --

## Nog meer

 ---

# Nieuw onderwerp

 --

## Enzovoort 

```

<small>*Wellicht geen goed idee.</small>

--

## Commando's

```javascripts
kc init
kc serve
kc print
kc install
kc --help
```

--

## Markdown

[https://daringfireball.net/projects/markdown/](https://daringfireball.net/projects/markdown/)

--

# That's it

Je bent klaar. Open Visual Studio Code. Verwijder `slides\!help.md` en voeg je eigen slides toe.