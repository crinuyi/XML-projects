<?xml version="1.0" encoding="iso8859-2" ?>
<xsl:stylesheet
        version="1.0"
        xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:template match="/">
        <title>Projekt</title>
    </xsl:template>
    <xsl:template match="/">
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
                            </tr>
                            <xsl:for-each select="rysunki/kategoria/podkategoria">
                                    <tr>
                                        <td><xsl:value-of select="nazwa"/></td>
                                        <td><xsl:value-of select="autor"/></td>
                                        <td><xsl:value-of select="rozmiar"/></td>
                                        <td><xsl:value-of select="opis"/></td>
                                        <td><xsl:value-of select="dlugosc"/></td>
                                        <td><xsl:value-of select="szerokosc"/></td>
                                    </tr>
                            </xsl:for-each>
                        </table>
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
                    </td>
                    <td>
                        <table>
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
                                        <td><xsl:value-of select="specjalne">

                                        </xsl:value-of></td>
                                    </tr>
                            </xsl:for-each>
                        </table>
                    </td>
                </tr>
              </xsl:for-each>
        </table>
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>