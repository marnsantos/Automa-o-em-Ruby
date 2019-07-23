package PermissaoAcesso;

import io.restassured.path.json.JsonPath;

import static io.restassured.RestAssured.given;

public class ObterPermissao {

    public static String ObterPermissaoUsuario(String login, String senha){

        JsonPath jsonPath = given()
                .header("Accept","application/json")
                .contentType("application/json")
                .body("{\"login\":\"teste@teste.com\",\"senha\":\"123456\",\"system\": \"PESCATTU_ADMIN\"}")
                .post("/auth")
                .andReturn()
                .jsonPath();

        return jsonPath.getString("data.token");
    }
}
