/**
 * Curso: Elementos de Sistemas
 * Arquivo: Code.java
 */
package assembler;

import java.util.Arrays;
import java.util.List;

/**
 * Traduz mnemônicos da linguagem assembly para códigos binários da arquitetura Z0.
 */
public class Code {
    /**
     * Retorna o código binário do(s) registrador(es) que vão receber o valor da instrução.
     * @param  mnemnonic vetor de mnemônicos "instrução" a ser analisada.
     * @return Opcode (String de 4 bits) com código em linguagem de máquina para a instrução.
     */
    public static String dest(String[] mnemnonic) {
        /* TODO: implementar */
        if (!mnemnonic[0].equals("movw")) {
            switch (mnemnonic[mnemnonic.length -1]) {
                case "%A":
                    return "0001";
                case "%D":
                    return "0010";
                case "(%A)":
                    return "0100";
                default:
                    return "0000";
            }
        }
        else {
            if (mnemnonic.length > 3){
                switch (mnemnonic[mnemnonic.length -1]){
                    case "%A":
                        if (mnemnonic[mnemnonic.length -2].equals("(%A)")){
                            return "0101";
                        }
                        else if (mnemnonic[mnemnonic.length - 2].equals("%D")){
                            return  "0011";
                        }
                        else {
                            return "0001";
                        }
                    case "%D":
                        if (mnemnonic[mnemnonic.length -2].equals("(%A)")){
                            return "0110";
                        }
                        else if (mnemnonic[mnemnonic.length - 2].equals("%A")){
                            return  "0011";
                        }
                        else {
                            return "0010";
                        }
                    case "(%A)":
                        if (mnemnonic[mnemnonic.length -2].equals("%A")){
                            return "0101";
                        }
                        else if (mnemnonic[mnemnonic.length - 2].equals("%D")){
                            return  "0110";
                        }
                        else {
                            return "0100";
                        }
                }
            }
            else {
                switch (mnemnonic[mnemnonic.length -1]) {
                    case "%A":
                        return "0001";
                    case "%D":
                        return "0010";
                    case "(%A)":
                        return "0100";
                    default:
                        return "0000";
                }
            }
        }
        return "0000";
    }
    /**
     * Retorna o código binário do mnemônico para realizar uma operação de cálculo.
     * @param  mnemnonic vetor de mnemônicos "instrução" a ser analisada.
     * @return Opcode (String de 7 bits) com código em linguagem de máquina para a instrução.
     */
    public static String comp(String[] mnemnonic) {
        switch (mnemnonic[0]) {
            case "movw":
                switch (mnemnonic[1]) {
                    case "%A":
                        return "000110000";
                    case "%D":
                        return "000001100";
                    case "(%A)":
                        return "001110000";
                    case "$1":
                        return "000111111";
                    case "$0":
                        return "000101010";
                }
            case "notw":
                switch (mnemnonic[1]) {
                    case "%D":
                        return "000001101";
                    case "%A":
                        return "000110001";
                    case "(%A)":
                        return "001110001";
                }
            case "negw":
                switch (mnemnonic[1]) {
                    case "%D":
                        return "000001111";
                    case "%A":
                        return "000110011";
                    case "(%A)":
                        return "001110011";
                }
            case "incw":
                switch (mnemnonic[1]) {
                    case "%A":
                        return "000110111";
                    case "%D":
                        return "000011111";
                    case "(%A)":
                        return "001110111";
                }
            case "andw":
                switch (mnemnonic[1]) {
                    case "(%A)":
                        return "001000000";
                    case "%D":
                    case "%A":
                        return "000000000";
                }
            case "addw":
                // 0  1  2  3  4  5  6 7
                // 00 r0 zx nx zy ny f no
                List<String> resultado = Arrays.asList("00", "0", "0", "0", "0", "0", "1", "0");
                if (mnemnonic[1].equals("$1")){
                        if (mnemnonic[2].equals("%D")){
                            resultado.set(2, "0");
                            resultado.set(3, "1");
                            resultado.set(4, "1");
                            resultado.set(5, "1");
                            resultado.set(7, "1");
                        }
                        else if (mnemnonic[2].equals("%A")) {
                            resultado.set(2, "1");
                            resultado.set(3, "1");
                            resultado.set(5, "1");
                            resultado.set(7, "1");
                        }
                        else if (mnemnonic[2].equals("(%A)")) {
                            resultado.set(1, "1");
                            resultado.set(2, "1");
                            resultado.set(3, "1");
                            resultado.set(5, "1");
                            resultado.set(7, "1");
                        }
                } else if (mnemnonic[1].equals("$-1")){
                    if (mnemnonic[2].equals("%D")){
                            resultado.set(4, "1");
                            resultado.set(5, "1");
                    } else if (mnemnonic[2].equals("%A")) {
                        resultado.set(2, "1");
                        resultado.set(3, "1");
                    } else if (mnemnonic[2].equals("(%A)")){
                            resultado.set(1, "1");
                            resultado.set(2, "1");
                            resultado.set(3, "1");
                    }
                }
                for (int i = 1; i <= 2; i++){
                    if (mnemnonic[i].equals("(%A)")) {
                        resultado.set(1, "1");
                    }
                }

                return  String.join("", resultado);
            case "decw":
                switch (mnemnonic[1]) {
                    case "%D":
                        return "000001110";
                    case "%A":
                        return "000110010";
                    case "(%A)":
                        return "001110010";
                }
            case "orw":
                switch (mnemnonic[1]) {
                    case "%D":
                    case "%A":
                        return "000010101";
                    case "(%A)":
                        return "001010101";
                }
            case "subw":

                String result = "";
                if (mnemnonic[1].equals("%A")){
                    if (mnemnonic[2].equals("$1")){
                        return "000110010";
                    }
                    result = "00a000111";

                } else if (mnemnonic[1].equals("%D")){
                    if (mnemnonic[2].equals("$1")){
                        return "000001110";
                    }
                    result = "00a010011";
                } else if (mnemnonic[1].equals("(%A)")) {
                    if (mnemnonic[2].equals("$1")){
                        return "001110010";
                    }
                    result = "001000111";
                }
                if (mnemnonic[2].equals("(%A)")){
                    result = result.replace("a", "1");
                } else {
                    result = result.replace("a", "0");
                }
                return result;

            case "rsubw":
                if ("%D".equals(mnemnonic[1])) {
                    return "001000111";
                }
            default:
                return "000001100";
        }
    }
    /**
     * Retorna o código binário do mnemônico para realizar uma operação de jump (salto).
     * @param  mnemnonic vetor de mnemônicos "instrução" a ser analisada.
     * @return Opcode (String de 3 bits) com código em linguagem de máquina para a instrução.
     */
    public static String jump(String[] mnemnonic) {
        /* TODO: implementar */
        switch (mnemnonic[0]) {
            case "jg":
                return "001";
            case "je":
                return "010";
            case "jge":
                return "011";
            case "jl":
                return "100";
            case "jne":
                return "101";
            case "jle":
                return "110";
            case "jmp":
                return "111";
            default:
                return "000";
        }
    }
    /**
     * Retorna o código binário de um valor decimal armazenado numa String.
     * @param  symbol valor numérico decimal armazenado em uma String.
     * @return Valor em binário (String de 15 bits) representado com 0s e 1s.
     */
    public static String toBinary(String symbol) {
        /* TODO: implementar */
        int symbol_value = Integer.parseInt(symbol);
        String binary = Integer.toBinaryString(symbol_value);
        return String.format("%1$16s", binary).replace(" ", "0");
    }
}