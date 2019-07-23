import Classe.ProdutoResponse;
import PermissaoAcesso.ObterPermissao;
import io.restassured.RestAssured;
import io.restassured.path.json.JsonPath;
import org.junit.Before;
import org.junit.Test;

import static io.restassured.RestAssured.given;

public class ProductWebController {

    String token;

    @Before
    public void setup(){
        RestAssured.baseURI = "http://172.100.10.142";
        RestAssured.port = 8383;

        token = ObterPermissao.ObterPermissaoUsuario("teste@teste.com", "123456");
    }

    @Test
    public void testListAllProduct(){

        JsonPath jsonPath = given()
                                .header("Accept", "application/json")
                                .header("Authorization", token)
                            .then()
                                .statusCode(200)
                            .when()
                                .get("/product")
                            .andReturn()
                            .jsonPath();


        ProdutoResponse response = jsonPath.getObject("", ProdutoResponse.class);
        System.out.print(response.getData().getContent().size());

    }




}
