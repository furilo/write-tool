# frozen_string_literal: true

require "test_helper"

class PromptCompilerTest < ActiveSupport::TestCase
  def test_compiles_a_string_prompt
    prompt = "Eres un {{what}}"
    variables = {
      what: "un asistente especializado en administración pública en España"
    }

    compiler = PromptCompiler.new prompt, variables
    assert_equal compiler.compile, "Eres un un asistente especializado en administración pública en España"
  end

  def test_compiles_a_hash_prompt
    prompt = [
      {
        role: "system", content: "Eres un {{what}}"
      },
      {
        role: "user", content: "Eres experto en extraer las palabras clave de las licitaciones. Te voy a dar unos ejemplos: {{few_shots}}"
      },
      {
        role: "user", content: "Extrae entre 3 y 5 palabras clave de la siguiente licitación: \n {{tender_title}}\n"
      }
    ]
    variables = {
      what: "un asistente especializado en administración pública en España",
      few_shots: "\nLicitación: Construcción de un edificio de viviendas en la calle de la Paz, 12, 28001 Madrid. Palabras clave: edificio, viviendas, calle, paz, madrid.\nLicitación: Instalación y mantenimiento de ascensores en Hospital La Fe, Valencia. Palabras clave: instalación, mantenimiento, ascensores, hospital, la fe, valencia.",
      tender_title: "Instalación software Decidim en Ayuntamiento de Madrid"
    }

    compiler = PromptCompiler.new prompt, variables
    assert_equal compiler.compile, [
      {
        role: "system", content: "Eres un un asistente especializado en administración pública en España"
      },
      {
        role: "user", content: "Eres experto en extraer las palabras clave de las licitaciones. Te voy a dar unos ejemplos: \nLicitación: Construcción de un edificio de viviendas en la calle de la Paz, 12, 28001 Madrid. Palabras clave: edificio, viviendas, calle, paz, madrid.\nLicitación: Instalación y mantenimiento de ascensores en Hospital La Fe, Valencia. Palabras clave: instalación, mantenimiento, ascensores, hospital, la fe, valencia."
      },
      {
        role: "user", content: "Extrae entre 3 y 5 palabras clave de la siguiente licitación: \n Instalación software Decidim en Ayuntamiento de Madrid\n"
      }
    ]
  end
end
