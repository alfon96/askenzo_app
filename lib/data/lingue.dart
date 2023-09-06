import 'package:flutter/material.dart';

/// The above code is defining an enumeration called "Languages" in Dart. It includes four language
/// options: italiano, english, french, and deutsch.
enum Languages {
  italiano,
  english,
  french,
  deutsch,
}

/// The class LingueValidazioneForm contains a map of validation messages in different languages.
class LingueValidazioneForm {
  static const Map<Languages, List<String>> testoValidazione =
      <Languages, List<String>>{
    Languages.italiano: [
      'Per favore inserisci un indirizzo email valido.',
      'Per favore inserisci la password corretta.',
      'Le password inserite non coincidono.',
      'Questo campo non può essere nullo e non può contenere numeri.',
      'Inserisci un numero di telefono valido.'
    ],
    Languages.english: [
      'Please enter a valid email address.',
      'Please enter the correct password.',
      'The entered passwords do not match.',
      'This field cannot be empty and cannot contain numbers.',
      'Please enter a valid phone number.'
    ],
    Languages.french: [
      'Veuillez entrer une adresse email valide.',
      'Veuillez entrer le mot de passe correct.',
      'Les mots de passe saisis ne correspondent pas.',
      'Ce champ ne peut pas être vide et ne peut pas contenir de chiffres.',
      'Veuillez entrer un numéro de téléphone valide.'
    ],
    Languages.deutsch: [
      'Bitte geben Sie eine gültige E-Mail-Adresse ein.',
      'Bitte geben Sie das richtige Passwort ein.',
      'Die eingegebenen Passwörter stimmen nicht überein.',
      'Dieses Feld darf nicht leer sein und darf keine Zahlen enthalten.',
      'Bitte geben Sie eine gültige Telefonnummer ein.'
    ],
  };
}

/// The class LingueUsersProfiles contains a static constant map that stores different language versions
/// of user profile settings.
class LingueUsersProfiles {
  static const Map<Languages, List<String>> paginaSetup =
      <Languages, List<String>>{
    Languages.italiano: [
      'Elimina foto',
      'IMPOSTAZIONI ACCOUNT',
      'Modifica Profilo',
      'Prenotazioni experience',
      'Cambia password',
      'Segnalazioni',
      'Rimuovi account',
      'Log out',
      'Modifica Servizi',
    ],
    Languages.english: [
      'Delete photo',
      'ACCOUNT SETTINGS',
      'Edit Profile',
      'Experience Bookings',
      'Change password',
      'Reports',
      'Remove account',
      'Log out',
      'Edit Services',
    ],
    Languages.french: [
      'Supprimer la photo',
      'PARAMÈTRES DU COMPTE',
      'Modifier le profil',
      'Réservations d\'expérience',
      'Changer le mot de passe',
      'Signalements',
      'Supprimer le compte',
      'Se déconnecter',
      'Modifier les services',
    ],
    Languages.deutsch: [
      'Foto löschen',
      'KONTOEINSTELLUNGEN',
      'Profil bearbeiten',
      'Erfahrungsbuchungen',
      'Passwort ändern',
      'Meldungen',
      'Konto löschen',
      'Abmelden',
      'Dienste bearbeiten',
    ],
  };
}

/// The class LinguePasswordDimenticata contains a map of language-specific strings for a forgot
/// password form.
class LinguePasswordDimenticata {
  static const Map<Languages, List<String>> linguaCampiForm =
      <Languages, List<String>>{
    Languages.italiano: [
      'Password dimenticata',
      'Inserisci qui il tuo indirizzo email per ricevere il link di ripristino della password',
      'Invia',
      'Link di recupero inviato',
      'Perfetto! L\'email contenente il tuo link di recupero è stata inviata correttamente. \nUtilizza il link che ti abbiamo inviato per reimpostare la tua password.',
      'Torna alla Home',
    ],
    Languages.english: [
      'Forgot Password',
      'Enter your email address here to receive the password reset link',
      'Send',
      'Recovery Link Sent',
      'Great! The email containing your recovery link has been successfully sent. \nUse the link we sent you to reset your password.',
      'Back to Home',
    ],
    Languages.french: [
      'Mot de passe oublié',
      'Entrez votre adresse e-mail ici pour recevoir le lien de réinitialisation du mot de passe',
      'Envoyer',
      'Lien de récupération envoyé',
      'Parfait ! L\'e-mail contenant votre lien de récupération a été envoyée avec succès. \nUtilisez le lien que nous vous avons envoyé pour réinitialiser votre mot de passe.',
      'Retour à l\'accueil',
    ],
    Languages.deutsch: [
      'Passwort vergessen',
      'Geben Sie hier Ihre E-Mail-Adresse ein, um den Link zum Zurücksetzen des Passworts zu erhalten',
      'Senden',
      'Wiederherstellungslink gesendet',
      'Perfekt! Die E-Mail mit Ihrem Wiederherstellungslink wurde erfolgreich gesendet. \nVerwenden Sie den von uns gesendeten Link, um Ihr Passwort zurückzusetzen.',
      'Zurück zur Startseite',
    ],
  };
}

/// The class LingueFormUserLogin contains static maps that store login phrases and form field labels in
/// different languages.
class LingueFormUserLogin {
  static const Map<Languages, String> linguaLogIn = <Languages, String>{
    Languages.italiano: 'Accedi',
    Languages.english: 'Sign in',
    Languages.french: 'Se connecter',
    Languages.deutsch: 'Anmelden',
  };

  static const Map<Languages, List<String>> linguaCampiForm =
      <Languages, List<String>>{
    Languages.italiano: [
      'Utente',
      'Password',
      'Password dimenticata?',
      'Clicca qui',
      'Accedi',
      'Non hai ancora un account?',
      'Registrati'
    ],
    Languages.english: [
      'User',
      'Password',
      'Forgot password?',
      'Click here',
      'Log in',
      'Don\'t have an account yet?',
      'Sign up'
    ],
    Languages.french: [
      'Utilisateur',
      'Mot de passe',
      'Mot de passe oublié ?',
      'Cliquez ici',
      'Se connecter',
      'Vous n\'avez pas encore de compte ?',
      'S\'inscrire'
    ],
    Languages.deutsch: [
      'Benutzer',
      'Passwort',
      'Passwort vergessen?',
      'Hier klicken',
      'Anmelden',
      'Sie haben noch keinen Account?',
      'Registrieren'
    ],
  };
}

/// The PhoneNumberZone class contains a map of research phrases in different languages.
class PhoneNumberZone {
  static const Map<Languages, String> researchPhoneZone = {
    Languages.italiano: 'Cerca...',
    Languages.english: 'Search...',
    Languages.french: 'Rechercher...',
    Languages.deutsch: 'Suche...',
  };
}

/// The class LingueFormRegistrazione contains static constants for different languages used in a
/// registration form.
class LingueFormRegistrazione {
  static const Map<Languages, String> linguaRequisitoPassword =
      <Languages, String>{
    Languages.italiano:
        'La tua password deve avere: Almeno 8 caratteri, almeno una lettera maiuscola e una minuscola, almeno due numeri.',
    Languages.english:
        'Your password must have: At least 8 characters, at least one uppercase letter and one lowercase letter, at least two numbers.',
    Languages.french:
        'Votre mot de passe doit comporter : Au moins 8 caractères, au moins une lettre majuscule et une lettre minuscule, au moins deux chiffres.',
    Languages.deutsch:
        'Dein Passwort muss folgende Anforderungen erfüllen: Mindestens 8 Zeichen, mindestens ein Großbuchstabe und ein Kleinbuchstabe, mindestens zwei Zahlen.',
  };

  static const Map<Languages, String> registrati = <Languages, String>{
    Languages.italiano: 'Registrati',
    Languages.english: 'Sign Up',
    Languages.french: 'Inscription',
    Languages.deutsch: 'Registrieren',
  };

  static const Map<Languages, String> linguaTestoPrivacy = <Languages, String>{
    Languages.italiano: 'È necessario accettare le condizioni di Privacy.',
    Languages.english: 'It is necessary to accept the Privacy conditions.',
    Languages.french:
        'Il est nécessaire d\'accepter les conditions de confidentialité.',
    Languages.deutsch:
        'Es ist erforderlich, die Datenschutzbestimmungen zu akzeptieren.',
  };

  static const Map<Languages, String> linguaTerminiServizio =
      <Languages, String>{
    Languages.italiano:
        'Creando un account, accetti i nostri Termini di servizio e la Dichiarazione sulla privacy e sui cookie.',
    Languages.english:
        'By creating an account, you agree to our Terms of Service and Privacy Policy and Cookie Statement.',
    Languages.french:
        'En créant un compte, vous acceptez nos Conditions d\'utilisation et notre Politique de confidentialité et Déclaration relative aux cookies.',
    Languages.deutsch:
        'Durch das Erstellen eines Kontos stimmen Sie unseren Nutzungsbedingungen und unserer Datenschutzrichtlinie sowie unserer Cookie-Richtlinie zu.',
  };

  static const Map<Languages, List> linguaCampiForm = <Languages, List>{
    Languages.italiano: [
      'EMAIL *',
      'PASSWORD *',
      'NOME *',
      'COGNOME *',
      'TELEFONO',
      'REGISTRATI'
    ],
    Languages.english: [
      'EMAIL *',
      'PASSWORD *',
      'FIRST NAME *',
      'LAST NAME *',
      'PHONE',
      'REGISTER'
    ],
    Languages.french: [
      'EMAIL *',
      'MOT DE PASSE *',
      'NOM *',
      'PRÉNOM *',
      'TÉLÉPHONE',
      'S\'INSCRIRE'
    ],
    Languages.deutsch: [
      'EMAIL *',
      'PASSWORT *',
      'VORNAME *',
      'NACHNAME *',
      'TELEFON',
      'REGISTRIEREN'
    ],
  };

  static const Map<Languages, List> linguaValidazioneForm = <Languages, List>{
    Languages.italiano: [
      'Per favore inserisci un indirizzo email valido.',
      'Per favore inserisci una password valida.',
      'Le password inserite non coincidono.',
      'Il nome non può essere nullo e non può contenere numeri.',
      'Il cognome non può essere nullo e non può contenere numeri.',
      'Inserisci un numero di telefono valido.'
    ],
    Languages.english: [
      'Please enter a valid email address.',
      'Please enter a valid password.',
      'The passwords entered do not match.',
      'Name cannot be empty and cannot contain numbers.',
      'Surname cannot be empty and cannot contain numbers.',
      'Please enter a valid phone number.'
    ],
    Languages.french: [
      'Veuillez entrer une adresse email valide.',
      'Veuillez entrer un mot de passe valide.',
      'Les mots de passe saisis ne correspondent pas.',
      'Le nom ne peut pas être vide et ne peut pas contenir de chiffres.',
      'Le nom de famille ne peut pas être vide et ne peut pas contenir de chiffres.',
      'Veuillez entrer un numéro de téléphone valide.'
    ],
    Languages.deutsch: [
      'Bitte geben Sie eine gültige E-Mail-Adresse ein.',
      'Bitte geben Sie ein gültiges Passwort ein.',
      'Die eingegebenen Passwörter stimmen nicht überein.',
      'Der Name darf nicht leer sein und darf keine Zahlen enthalten.',
      'Der Nachname darf nicht leer sein und darf keine Zahlen enthalten.',
      'Bitte geben Sie eine gültige Telefonnummer ein.'
    ],
  };

  static const Map<Languages, List> linguaSuggerimentiForm = <Languages, List>{
    Languages.italiano: [
      'es. enzosurf@brindisi.it',
      'Password',
      'Conferma password',
      'es. Mario',
      'es. Rossi',
      'es. 312 3456789',
    ],
    Languages.english: [
      'es. enzosurf@brindisi.uk',
      'Password',
      'Confirm password',
      'es. John',
      'es. Smith',
      'es. 20 1234 5678',
    ],
    Languages.french: [
      'es. enzosurf@brindisi.fr',
      'Mot de passe',
      'Confirmer le mot de passe',
      'es. Jean',
      'es. Martin',
      'es. 6 12 34 56 78',
    ],
    Languages.deutsch: [
      'es. enzosurf@brindisi.de',
      'Passwort',
      'Passwort bestätigen',
      'es. Maximilian',
      'es. Müller',
      'es. 1512 3456789',
    ],
  };
  static const Map<String, Icon> mapFieldIcon = <String, Icon>{
    'email': Icon(Icons.mail),
    'nome': Icon(Icons.person),
    'cognome': Icon(Icons.person),
    'telefono': Icon(Icons.phone_android),
  };
  static const Map<Languages, String> linguaSnackBar = <Languages, String>{
    Languages.italiano:
        'Congratulazioni! La tua richiesta è stata correttamente inviata al server.',
    Languages.english:
        'Congratulations! Your request has been successfully sent to the server.',
    Languages.french:
        'Félicitations ! Votre demande a été envoyée avec succès au serveur.',
    Languages.deutsch:
        'Herzlichen Glückwunsch! Ihre Anfrage wurde erfolgreich an den Server gesendet.',
  };
}

/// The class LingueFormRegistrazioneHost contains static maps that store language-specific suggestions,
/// titles, fields, and subtitles for a registration form.
class LingueFormRegistrazioneHost {
  static const Map<Languages, List> linguaSuggerimentiForm = <Languages, List>{
    Languages.italiano: [
      'es. enzosurf@brindisi.it',
      'Password',
      'Conferma password',
      'es. B&B Askenzo',
    ],
    Languages.english: [
      'es. enzosurf@brindisi.uk',
      'Password',
      'Confirm password',
      'es. B&B Askenzo',
    ],
    Languages.french: [
      'es. enzosurf@brindisi.fr',
      'Mot de passe',
      'Confirmer le mot de passe',
      'es. B&B Askenzo',
    ],
    Languages.deutsch: [
      'es. enzosurf@brindisi.de',
      'Passwort',
      'Passwort bestätigen',
      'es. B&B Askenzo',
    ],
  };

  static const Map<String, Icon> mapFieldIcon = <String, Icon>{
    'email': Icon(Icons.mail),
    'nome': Icon(Icons.house_outlined),
  };

  static const Map<Languages, List> linguaTitoliForm = <Languages, List>{
    Languages.italiano: [
      'Inserisci la tua struttura su Ask Enzo',
      'Inizia subito, la tua registrazione può essere completata in soli 15 minuti.'
    ],
    Languages.english: [
      'Add your structure on Ask Enzo',
      'Get started now, your registration can be completed in just 15 minutes.'
    ],
    Languages.french: [
      'Ajoutez votre structure sur Ask Enzo',
      'Commencez dès maintenant, votre inscription peut être complétée en seulement 15 minutes.'
    ],
    Languages.deutsch: [
      'Fügen Sie Ihre Struktur auf Ask Enzo hinzu',
      'Legen Sie jetzt los, Ihre Registrierung kann in nur 15 Minuten abgeschlossen werden.'
    ],
  };
  static const Map<Languages, List> linguaCampiForm = <Languages, List>{
    Languages.italiano: [
      '1 Crea il tuo account',
      '2 Compila tutti i campi',
      'NOME STRUTTURA',
      'EMAIL',
      'PASSWORD'
    ],
    Languages.english: [
      '1 Create your account',
      '2 Fill in all fields',
      'STRUCTURE NAME',
      'EMAIL',
      'PASSWORD'
    ],
    Languages.french: [
      '1 Créez votre compte',
      '2 Remplissez tous les champs',
      'NOM DE LA STRUCTURE',
      'EMAIL',
      'MOT DE PASSE'
    ],
    Languages.deutsch: [
      '1 Erstelle dein Konto',
      '2 Fülle alle Felder aus',
      'STRUKTURNAME',
      'EMAIL',
      'PASSWORT'
    ],
  };
  static const Map<Languages, List<String>> sottotitoliForm =
      <Languages, List<String>>{
    Languages.italiano: [
      'Iscriviti e registra il tuo profilo. Inizia subito a compilare la tua domanda per entrare nel circuito.',
      'Completa tutti i passaggi ed è fatta! Il nostro team ti contatterà.'
    ],
    Languages.english: [
      'Sign up and register your profile. Start filling out your application to join the circuit.',
      'Complete all the steps and you\'re done! Our team will contact you.'
    ],
    Languages.french: [
      'Inscrivez-vous et enregistrez votre profil. Commencez dès maintenant à remplir votre demande pour rejoindre le circuit.',
      'Terminez toutes les étapes et vous avez terminé ! Notre équipe vous contactera.'
    ],
    Languages.deutsch: [
      'Registriere dich und erstelle dein Profil. Fange sofort an, deine Bewerbung auszufüllen, um dem Circuit beizutreten.',
      'Vervollständige alle Schritte und du bist fertig! Unser Team wird dich kontaktieren.'
    ],
  };
}

/// The class LingueFormPrenotazione contains static maps that store translations and other
/// language-related data for a booking form in different languages.
class LingueFormPrenotazione {
  static const Map<Languages, String> prenota = <Languages, String>{
    Languages.italiano: 'Prenota',
    Languages.english: 'Book',
    Languages.french: 'Réserver',
    Languages.deutsch: 'Buchen',
  };

  static const Map<Languages, List> linguaCampiForm = <Languages, List>{
    Languages.italiano: [
      'DATA PRENOTAZIONE *',
      'N° DI PERSONE',
      'TELEFONO *',
      'LINGUA DI PREFERENZA *',
      'Procedi al pagamento'
    ],
    Languages.english: [
      'BOOKING DATE *',
      'N° OF PEOPLE *',
      'TELEPHONE *',
      'PREFERRED LANGUAGE *',
      'Proceed to payment'
    ],
    Languages.french: [
      'DATE DE RÉSERVATION *',
      'N° DE PERSONNES *',
      'TÉLÉPHONE *',
      'LANGUE DE PRÉFÉRENCE *',
      'Procédez au paiement'
    ],
    Languages.deutsch: [
      'BUCHUNGSDATUM  *',
      'N° VON MENSCHEN *',
      'TELEFON *',
      'BEVORZUGTE SPRACHE *',
      'Zur Kasse gehen'
    ],
  };
  static const Map<Languages, List> linguaValidazioneForm = <Languages, List>{
    Languages.italiano: [
      'Per favore inserisci una data valida.',
      'Inserisci il numero di partecipanti.',
      'Inserisci un numero di telefono valido.',
    ],
    Languages.english: [
      'Please enter a valid date.',
      'Enter the number of participants.',
      'Enter a valid phone number.',
    ],
    Languages.french: [
      'Veuillez entrer une date valide.',
      'Entrez le nombre de participants.',
      'Entrez un numéro de téléphone valide.',
    ],
    Languages.deutsch: [
      'Bitte geben Sie ein gültiges Datum ein.',
      'Geben Sie die Anzahl der Teilnehmer ein.',
      'Geben Sie eine gültige Telefonnummer ein.',
    ],
  };
  static const Map<Languages, List> linguaSuggerimentiForm = <Languages, List>{
    Languages.italiano: [
      'Seleziona una data',
      'Ex. 2',
      'Ex. 3715849584',
    ],
    Languages.english: [
      'Enter a date.',
      'Ex. 2',
      'Ex. 3715849584',
    ],
    Languages.french: [
      'Entrer une date.',
      'Ex. 2',
      'Ex. 3715849584',
    ],
    Languages.deutsch: [
      'Wählen Sie ein Datum aus',
      'Ex. 2',
      'Ex. 3715849584',
    ],
  };
  static const Map<Languages, String> linguaSnackBar = <Languages, String>{
    Languages.italiano:
        'Congratulazioni! La tua richiesta è stata correttamente inviata al server.',
    Languages.english:
        'Congratulations! Your request has been successfully sent to the server.',
    Languages.french:
        'Félicitations ! Votre demande a été envoyée avec succès au serveur.',
    Languages.deutsch:
        'Herzlichen Glückwunsch! Ihre Anfrage wurde erfolgreich an den Server gesendet.',
  };
  static const Map<String, Color> colorMap = <String, Color>{
    'formFieldTitleColor': Colors.blue,
    'formFieldInputColor': Colors.black,
  };
  static Map<Languages, Image> languages = <Languages, Image>{
    Languages.italiano: Image.asset('assets/flags/it.png'),
    Languages.english: Image.asset('assets/flags/gb-nir.png'),
    Languages.french: Image.asset('assets/flags/fr.png'),
    Languages.deutsch: Image.asset('assets/flags/de.png'),
  };
}

/// The class LingueScreenContenuti contains a static map that stores content in different languages.
class LingueScreenContenuti {
  static const Map<Languages, List> contenuti = <Languages, List>{
    Languages.italiano: ['Chiedi ad Enzo', 'Scopri Brindisi', 'Esperienze'],
    Languages.english: ['Ask Enzo', 'Discover Brindisi', 'Experiences'],
    Languages.french: ['Demandez à Enzo', 'Découvrez Brindisi', 'Expériences'],
    Languages.deutsch: ['Frag Enzo', 'Entdecke Brindisi', 'Erlebnisse'],
  };
}

/// The LingueDiscovery class contains static maps and lists for different languages related to
/// discovering and exploring various aspects of a location.
class LingueDiscovery {
  static const Map<Languages, String> linguaAppBar = <Languages, String>{
    Languages.italiano: 'Scopri',
    Languages.english: 'Discover',
    Languages.french: 'Découvrir',
    Languages.deutsch: 'Entdecken',
  };

  static const Map<Languages, List> discoveryScreen = <Languages, List>{
    Languages.italiano: ['Video', 'Cibo', 'Monumenti', 'Hotels'],
    Languages.english: ['Video', 'Food', 'Monuments', 'Hotels'],
    Languages.french: ['Vidéo', 'Nourriture', 'Monuments', 'Hôtels'],
    Languages.deutsch: ['Video', 'Essen', 'Denkmäler', 'Hotels'],
  };
  static const Map<Languages, String> discoveryDetails = <Languages, String>{
    Languages.italiano: 'Punto di interesse',
    Languages.english: 'Point of interest',
    Languages.french: 'Point d\'intérêt',
    Languages.deutsch: 'Interessenspunkt',
  };
  static const lengthPopUpSentences = 3;
  static const Map<Languages, List> popUpSentences = <Languages, List>{
    Languages.italiano: [
      'Sapevi che a Brindisi ci sono molti monumenti?',
      'Sapevi che Brindisi ha molti piatti tipici?',
      'Sapevi che a Brindisi ci sono molti hotel rinomati?'
    ],
    Languages.english: [
      'Did you know that Brindisi has many monuments?',
      'Did you know that Brindisi has many typical dishes?',
      'Did you know that Brindisi has many renowned hotels?'
    ],
    Languages.french: [
      'Saviez-vous que Brindisi compte de nombreux monuments?',
      'Saviez-vous que Brindisi propose de nombreux plats typiques?',
      'Saviez-vous que Brindisi compte de nombreux hôtels renommés?'
    ],
    Languages.deutsch: [
      'Wussten Sie, dass Brindisi viele Denkmäler hat?',
      'Wussten Sie, dass Brindisi viele typische Gerichte hat?',
      'Wussten Sie, dass Brindisi viele renommierte Hotels hat?'
    ],
  };
  static const Map<Languages, List> discoveryDetailScreen = <Languages, List>{
    Languages.italiano: ['Video', 'Cibo', 'Monumenti', 'Hotels'],
    Languages.english: ['Video', 'Food', 'Monuments', 'Hotels'],
    Languages.french: ['Vidéo', 'Nourriture', 'Monuments', 'Hôtels'],
    Languages.deutsch: ['Video', 'Essen', 'Denkmäler', 'Hotels'],
  };
}

/// The class LingueExperience contains static maps that store translations for different languages
/// related to experiences and user routes.
class LingueExperience {
  static const Map<Languages, String> linguaAppBar = <Languages, String>{
    Languages.italiano: 'Esperienze',
    Languages.english: 'Experiences',
    Languages.french: 'Expériences',
    Languages.deutsch: 'Erlebnisse',
  };

  static const Map<Languages, List> experienceScreen = <Languages, List>{
    Languages.italiano: [
      'Esperienza',
      'Durata',
      'Facile',
      'Medio',
      'Difficile'
    ],
    Languages.english: [
      'Experience',
      'Duration',
      'Easy',
      'Medium',
      'Difficult'
    ],
    Languages.french: ['Expérience', 'Durée', 'Facile', 'Moyen', 'Difficile'],
    Languages.deutsch: ['Erfahrung', 'Dauer', 'Einfach', 'Mittel', 'Schwierig'],
  };
  static const Map<Languages, List> linguaPercorsiUtente = <Languages, List>{
    Languages.italiano: [
      'Prenota',
      'Utente',
    ],
    Languages.english: [
      'Routes',
      'User',
    ],
    Languages.french: [
      'Itinéraires',
      'Utilisateur',
    ],
    Languages.deutsch: [
      'Routen',
      'Benutzer',
    ],
  };
}

/// The LingueDrawer class in Dart contains static maps that store language options and messages for
/// different languages.
class LingueDrawer {
  static const Map<Languages, List<String>> opzioni = <Languages, List<String>>{
    Languages.italiano: [
      'Accedi',
      'Registrati',
      'Su di Noi',
      'Privacy',
      'Termini di Utilizzo',
      'Log Out',
    ],
    Languages.english: [
      'Log In',
      'Sign Up',
      'About Us',
      'Privacy',
      'Terms of Use',
      'Log Out',
    ],
    Languages.french: [
      'Se connecter',
      'S\'inscrire',
      'À propos de nous',
      'Confidentialité',
      'Conditions d\'utilisation',
      'Se déconnecter',
    ],
    Languages.deutsch: [
      'Anmelden',
      'Registrieren',
      'Über uns',
      'Datenschutz',
      'Nutzungsbedingungen',
      'Abmelden',
    ],
  };
  static const Map<Languages, String> linguaAggiornata = <Languages, String>{
    Languages.italiano: 'Benvenuto! Lingua aggiornata correttamente',
    Languages.english: 'Welcome! Language updated successfully',
    Languages.french: 'Bienvenue ! Langue mise à jour avec succès',
    Languages.deutsch: 'Willkommen! Sprache erfolgreich aktualisiert',
  };

  static const Map<Languages, List<String>> linguaLogOut =
      <Languages, List<String>>{
    Languages.italiano: [
      'LogOut',
      'Vuoi veramente eseguire il logout?',
      'Annulla',
      'Conferma'
    ],
    Languages.english: [
      'LogOut',
      'Are you sure you want to log out?',
      'Cancel',
      'Confirm'
    ],
    Languages.french: [
      'LogOut',
      'Êtes-vous sûr de vouloir vous déconnecter ?',
      'Annuler',
      'Confirmer'
    ],
    Languages.deutsch: [
      'LogOut',
      'Möchten Sie sich wirklich abmelden?',
      'Abbrechen',
      'Bestätigen'
    ],
  };
}

/// The above code is defining a constant map called "linguaDialogoUscitaApp" that maps each language to
/// a corresponding exit message. The keys of the map are of type "Languages" and the values are of type
/// "String". The exit messages are provided in different languages such as Italian, English, French,
/// and German.
const Map<Languages, String> linguaDialogoUscitaApp = <Languages, String>{
  Languages.italiano: 'Vuoi uscire dall\'applicazione?',
  Languages.english: 'Do you want to exit the application?',
  Languages.french: 'Voulez-vous quitter l\'application ?',
  Languages.deutsch: 'Möchten Sie die Anwendung beenden?',
};

// Empty Language Field
// static const Map<Languages, List> linguaCampiForm = <Languages, List>{
//     Languages.italiano: [
//       'EMAIL *',
//       'PASSWORD *',
//       'NOME *',
//       'COGNOME *',
//       'TELEFONO'
//     ],
//     Languages.english: [
//       'EMAIL *',
//       'PASSWORD *',
//       'FIRST NAME *',
//       'LAST NAME *',
//       'PHONE'
//     ],
//     Languages.french: [
//       'EMAIL *',
//       'MOT DE PASSE *',
//       'NOM *',
//       'PRÉNOM *',
//       'TÉLÉPHONE'
//     ],
//     Languages.deutsch: [
//       'EMAIL *',
//       'PASSWORT *',
//       'VORNAME *',
//       'NACHNAME *',
//       'TELEFON'
//     ],
//   };
