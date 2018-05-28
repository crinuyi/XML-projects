import java.io.FileOutputStream;
import java.util.List;
import java.util.ArrayList;
import java.util.Map;
import java.util.HashMap;

// rejestr do tworzenia implementacji DOM
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.w3c.dom.*;
import org.w3c.dom.bootstrap.DOMImplementationRegistry;

// Implementacja DOM Level 3 Load & Save
import org.w3c.dom.ls.DOMImplementationLS;
import org.w3c.dom.ls.LSParser; // Do serializacji (zapisywania) dokumentow
import org.w3c.dom.ls.LSSerializer;
import org.w3c.dom.ls.LSOutput;

// Konfigurator i obsluga bledow

// Do pracy z dokumentem


public class Projekt {
	public static Document document,  document2;

	public static void main(String[] args) {
		if (args.length == 0) {
			printUsage();
			System.exit(1);
		}

		try {
			/*
			 * ustawienie systemowej wlasnosci (moze byc dokonane w innym
			 * miejscu, pliku konfiguracyjnym w systemie itp.) konkretna
			 * implementacja DOM
			 */
			System.setProperty(DOMImplementationRegistry.PROPERTY,
					"org.apache.xerces.dom.DOMXSImplementationSourceImpl");
			DOMImplementationRegistry registry = DOMImplementationRegistry.newInstance();

			// pozyskanie implementacji Load & Save DOM Level 3 z rejestru
			DOMImplementationLS impl =
				(DOMImplementationLS) registry.getDOMImplementation("LS");

			// stworzenie DOMBuilder
			LSParser builder = impl.createLSParser(
					DOMImplementationLS.MODE_SYNCHRONOUS, null);

			// pozyskanie konfiguratora - koniecznie zajrzec do dokumentacji co
			// mozna poustawiac
			DOMConfiguration config = builder.getDomConfig();

			// stworzenie DOMErrorHandler i zarejestrowanie w konfiguratorze
			DOMErrorHandler errorHandler = getErrorHandler();
			config.setParameter("error-handler", errorHandler);

			System.out.println("Parsowanie " + args[0] + "...");

			// sparsowanie dokumentu i pozyskanie "document" do dalszej pracy
			document = builder.parseURI(args[0]);

			DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();
			DocumentBuilder db = dbf.newDocumentBuilder();
			document2 = db.newDocument();

			//----------------------------------------------------------------------projekt
			// praca z dokumentem, modyfikacja zawartosci etc...
			String attribute = document.getElementsByTagName("kategoria_sklep").item(0).getAttributes().item(0).getTextContent();

			Element strona = document2.createElement("strona");
			Element sklep = document2.createElement("sklep");
			Element k_s = document2.createElement("kategoria_sklep");
			Element autor = document2.createElement("autor");
			Element seria = document2.createElement("seria");
			Element cena = document2.createElement("cena");
			Element cena_wysylki = document2.createElement("cena_wysylki");
			Element czas_oczekiwania = document2.createElement("czas_oczekiwania");
			document2.appendChild(strona);
			strona.appendChild(sklep);
			sklep.appendChild(k_s);
			k_s.appendChild(autor);
			k_s.appendChild(seria);
			k_s.appendChild(cena);
			k_s.appendChild(cena_wysylki);
			k_s.appendChild(czas_oczekiwania);
			if(attribute.equals("koszulka") && k_s.getNodeName().equals("kategoria_sklep"))
				k_s.setAttribute("nazwa_sklep", "t-shirt");
			else k_s.setAttribute("nazwa_sklep", attribute);

			String temp = document.getElementsByTagName("autor").item(0).getTextContent();
			autor.setTextContent(temp);
			temp = document.getElementsByTagName("seria").item(0).getTextContent();
			seria.setTextContent(temp);
			temp = document.getElementsByTagName("cena").item(0).getTextContent();
			cena.setTextContent(temp);
			temp = document.getElementsByTagName("cena_wysylki").item(0).getTextContent();
			cena_wysylki.setTextContent(temp);

			temp = document.getElementsByTagName("czas_oczekiwania").item(0).getTextContent();
			String textOut = "";
			for (int j = 0; j < temp.length(); j++) {
				if (temp.charAt(j) == ' ')
					break;
				textOut = textOut + temp.charAt(j);
			}
			czas_oczekiwania.setTextContent(textOut);

			int v;
			for(v=0; v<document.getElementsByTagName("sklep").getLength(); v++)
				v++;

			System.out.println("W nowym dokumencie zostało poddanych edycji " + v + " wierszy.");

			//-------------------------------------------------------------------------

			// pozyskanie serializatora
			LSSerializer domWriter = impl.createLSSerializer();
			// pobranie konfiguratora dla serializatora
			config = domWriter.getDomConfig();
			config.setParameter("xml-declaration", Boolean.TRUE);
			config.setParameter("format-pretty-print", Boolean.TRUE);

			// pozyskanie i konfiguracja Wyjscia
			LSOutput dOut = impl.createLSOutput();
			//dOut.setEncoding("latin2");
			dOut.setByteStream(new FileOutputStream(args[1]));

			System.out.println("Serializing document... ");
			domWriter.write(document2, dOut);

			// Wyjscie na ekran
			//dOut.setByteStream(System.out);
			//domWriter.write(System.out, document2);

		} catch (Exception ex) {
			ex.printStackTrace();
		}
	}

	private static void printUsage() {
		System.err.println("usage: java Ceny INPUT OUTPUT");
		System.err.println();
		System.err.println(
				"NOTE: You can only validate DOM tree against XML Schemas.");
	}

	// obsluga bledow za pomoca anonimowej klasy wewnetrznej implementujacej
	// DOMErrorHandler
	// por. SAX ErrorHandler

	public static DOMErrorHandler getErrorHandler() {
		return new DOMErrorHandler() {
			public boolean handleError(DOMError error) {
				short severity = error.getSeverity();
				if (severity == error.SEVERITY_ERROR)
					System.out.println("[dom3-error]: " + error.getMessage());
				if (severity == error.SEVERITY_WARNING)
					System.out.println("[dom3-warning]: " + error.getMessage());
				if (severity == error.SEVERITY_FATAL_ERROR)
					System.out.println("[dom3-fatal-error]: " + error.getMessage());
				return true;
			}
		};
	}
}