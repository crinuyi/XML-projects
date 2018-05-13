<?xml version="1.0" encoding="iso8859-2" ?>
<xsl:stylesheet
        version="1.0"
        xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="xml" indent="yes"/>

    <xsl:param name="srednia_wielkosc_pliku"/>

    <xsl:attribute-set name="podkreslenie">
        <xsl:attribute name="style">text-decoration:underline;</xsl:attribute>
    </xsl:attribute-set>


    <xsl:variable name="wazne">
        Oczekiwanie na produkt może wydłużyć się o 5 dni roboczych!
    </xsl:variable>

    <xsl:key name="klucz" match="kategoria_sklep" use="seria"/>

    <xsl:template match="/">

    <title>Projekt</title>

    <html>
        <head>
            <style type="text/css">
                table {border: solid black 1px; border-collapse: collapse;}
                td {border: solid black 1px; border-collapse: collapse;}
            </style>
        </head>
      <body>
          <table>
              <tr>
                  <td>Rysunki</td>
                  <td>Forum</td>
                  <td>Sklep</td>
              </tr>
              <xsl:for-each select="strona">
                <tr>
                    <td>
                        <table>
                            <tr>
                                 <td>Nazwa</td>
                                 <td>Autor</td>
                                 <td>Rozmiar</td>
                                 <td>Opis</td>
                                 <td>Długość</td>
                                 <td>Szerokość</td>
                                <td>Rodzaj rysunku</td>
                            </tr>
                                <xsl:for-each select="rysunki/kategoria/podkategoria">
                                        <tr>
                                            <td><xsl:value-of select="nazwa"/></td>
                                            <td><xsl:value-of select="autor"/></td>
                                            <td><xsl:value-of select="floor(rozmiar)"/></td>
                                            <td><xsl:value-of select="opis"/></td>
                                            <td><xsl:value-of select="dlugosc"/></td>
                                            <td><xsl:value-of select="szerokosc"/></td>
                                            <td><xsl:value-of select="@nazwa_rysunek"/></td>
                                        </tr>
                                </xsl:for-each>
                        </table>
                        <xsl:variable name="suma_rozm" select="sum(//rozmiar)"/>
                            Rozmiar rysunków na serwerze: <xsl:value-of select="$suma_rozm"/>
                        <p>Średni rozmiar pojedynczego rysunku na serwerze:
                        <xsl:variable name="srednia" select="sum(//rozmiar) div count(*)"/>
                            (zaokrąglone w górę): <xsl:value-of select="ceiling($srednia)"/>
                        </p>
                    </td>
                    <td>
                        <table>
                            <tr>
                                <td>Nazwa</td>
                                <td>Odpowiedzi</td>
                                <td>Ranking Tematu</td>
                                <td>Wyświetlenia</td>
                            </tr>
                            <xsl:for-each select="forum/dzial/temat">
                                <xsl:sort select="wyswietlenia"/>
                                <xsl:if test="tematZwykly &gt; 0">
                                    <tr>
                                        <td><xsl:value-of select="nazwa"/></td>
                                        <td><xsl:value-of select="odpowiedzi"/></td>
                                        <td><xsl:value-of select="rankingTematu"/></td>
                                        <td><xsl:value-of select="wyswietlenia"/></td>
                                  </tr>
                                </xsl:if>
                            </xsl:for-each>
                        </table>
                        Łączna ilość wyświetleń: <xsl:number value="sum(//wyswietlenia)"/>
                    </td>
                    <td>
                        <table>
                            <h4 xsl:use-attribute-sets="podkreslenie"><xsl:copy-of select="$wazne"/></h4>
                            <tr>
                                <td>Autor</td>
                                <td>Seria</td>
                                <td>Cena</td>
                                <td>Cena Wysyłki</td>
                                <td>Czas Oczekiwania</td>
                            </tr>
                            <xsl:for-each select="sklep/kategoria_sklep">
                                    <tr>
                                        <td><xsl:value-of select="autor"/></td>
                                        <td><xsl:value-of select="seria"/></td>
                                        <td><xsl:value-of select="cena"/></td>
                                        <td><xsl:value-of select="cena_wysylki"/></td>
                                        <td><xsl:value-of select="czas_oczekiwania"/></td>
                                        <td><xsl:value-of select="specjalne"/></td>
                                            <xsl:choose>
                                                <xsl:when test="dostepnosc &gt; 0">
                                                    <td bgcolor="#99ff66"></td>
                                                </xsl:when>
                                                <xsl:otherwise>
                                                    <td bgcolor="#ff9966"></td>
                                                </xsl:otherwise>
                                            </xsl:choose>
                                    </tr>
                            </xsl:for-each>
                        </table>
                        <xsl:for-each select="key('klucz','seria2')">
                        <h5 xsl:use-attribute-sets="podkreslenie">Seria promowana w tym miesiącu: <xsl:value-of select="seria"/></h5>
                        </xsl:for-each>
                    </td>
                </tr>
              </xsl:for-each>
        </table>
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>