require 'rails_helper'

def rotate_and_expect(face, direction, expectations)
  CubesService.rotate_cube(cube.id, face, direction)

  cube.reload
  
  expectations.each { |key, value| expect(cube.state[key]).to eq(value) }
end

RSpec.describe CubesService do
    let(:cube) { CubesService.create_cube }
    let(:reloaded_cube) { cube.reload }

    describe ".create_cube" do
        it "creates cube with initial state" do

            expect(cube).to be_persisted

            expect(cube.state["front"]).to all(eq(["R", "R", "R"]))
            expect(cube.state["back"]).to all(eq(["O", "O", "O"]))
            expect(cube.state["left"]).to all(eq(["G", "G", "G"]))
            expect(cube.state["right"]).to all(eq(["B", "B", "B"]))
            expect(cube.state["top"]).to all(eq(["W", "W", "W"]))
            expect(cube.state["bottom"]).to all(eq(["Y","Y","Y"]))
        end
    end

    describe ".rotate_cube" do
        it "rotates cube's top face to left" do
            CubesService.rotate_cube(cube.id, "top", "left")
            reloaded_cube

            expect(cube.state["top"]).to eq([["W","W","W"],["W","W","W"],["W","W","W"]])
            expect(cube.state["front"]).to eq([["B","B","B"],["R","R","R"],["R","R","R"]])
            expect(cube.state["right"]).to eq([["O","O","O"],["B","B","B"],["B","B","B"]])
            expect(cube.state["back"]).to eq([["G","G","G"],["O","O","O"],["O","O","O"]])
            expect(cube.state["left"]).to eq([["R","R","R"],["G","G","G"],["G","G","G"]])
        end

        it "rotates cube's top face to right" do
            CubesService.rotate_cube(cube.id, "top", "right")
            reloaded_cube

            expect(cube.state["top"]).to eq([["W","W","W"],["W","W","W"],["W","W","W"]])
            expect(cube.state["front"]).to eq([["G","G","G"],["R","R","R"],["R","R","R"]])
            expect(cube.state["right"]).to eq([["R","R","R"],["B","B","B"],["B","B","B"]])
            expect(cube.state["back"]).to eq([["B","B","B"],["O","O","O"],["O","O","O"]])
            expect(cube.state["left"]).to eq([["O","O","O"],["G","G","G"],["G","G","G"]])
        end

        it "rotates cube's bottom face to left" do
            CubesService.rotate_cube(cube.id, "bottom", "left")
            reloaded_cube

            expect(cube.state["front"]).to eq([["R","R","R"],["R","R","R"],["B","B","B"]])
            expect(cube.state["right"]).to eq([["B","B","B"],["B","B","B"],["O","O","O"]])
            expect(cube.state["back"]).to eq([["O","O","O"],["O","O","O"],["G","G","G"]])
            expect(cube.state["left"]).to eq([["G","G","G"],["G","G","G"],["R","R","R"]])
            expect(cube.state["bottom"]).to eq([["Y","Y","Y"],["Y","Y","Y"],["Y","Y","Y"]])
        end

        it "rotates cube's bottom face to right" do
            CubesService.rotate_cube(cube.id, "bottom", "right")
            reloaded_cube

            expect(cube.state["front"]).to eq([["R","R","R"],["R","R","R"],["G","G","G"]])
            expect(cube.state["right"]).to eq([["B","B","B"],["B","B","B"],["R","R","R"]])
            expect(cube.state["back"]).to eq([["O","O","O"],["O","O","O"],["B","B","B"]])
            expect(cube.state["left"]).to eq([["G","G","G"],["G","G","G"],["O","O","O"]])
            expect(cube.state["bottom"]).to eq([["Y","Y","Y"],["Y","Y","Y"],["Y","Y","Y"]])
        end

        it "rotates cube's middle layer around Y-axis to left" do
            CubesService.rotate_cube(cube.id, "middle-y", "left")
            reloaded_cube

            expect(cube.state["front"]).to eq([["R","R","R"],["B","B","B"],["R","R","R"]])
            expect(cube.state["right"]).to eq([["B","B","B"],["O","O","O"],["B","B","B"]])
            expect(cube.state["back"]).to eq([["O","O","O"],["G","G","G"],["O","O","O"]])
            expect(cube.state["left"]).to eq([["G","G","G"],["R","R","R"],["G","G","G"]])
        end

        it "rotates cube's middle layer around Y-axis to right" do
            CubesService.rotate_cube(cube.id, "middle-y", "right")
            reloaded_cube

            expect(cube.state["front"]).to eq([["R","R","R"],["G","G","G"],["R","R","R"]])
            expect(cube.state["right"]).to eq([["B","B","B"],["R","R","R"],["B","B","B"]])
            expect(cube.state["back"]).to eq([["O","O","O"],["B","B","B"],["O","O","O"]])
            expect(cube.state["left"]).to eq([["G","G","G"],["O","O","O"],["G","G","G"]])
        end

        it "rotates cube's left face up" do
            CubesService.rotate_cube(cube.id, "left", "up")
            reloaded_cube

            expect(cube.state["front"][0][0]).to eq("Y")
            expect(cube.state["front"][1][0]).to eq("Y")
            expect(cube.state["front"][2][0]).to eq("Y")

            expect(cube.state["bottom"][0][0]).to eq("O")
            expect(cube.state["bottom"][1][0]).to eq("O")
            expect(cube.state["bottom"][2][0]).to eq("O")

            expect(cube.state["back"][0][2]).to eq("W")
            expect(cube.state["back"][1][2]).to eq("W")
            expect(cube.state["back"][2][2]).to eq("W")

            expect(cube.state["top"][0][0]).to eq("R")
            expect(cube.state["top"][1][0]).to eq("R")
            expect(cube.state["top"][2][0]).to eq("R")
        end

        it "rotates cube's left face down" do
            CubesService.rotate_cube(cube.id, "left", "down")
            reloaded_cube

            expect(cube.state["front"][0][0]).to eq("W")
            expect(cube.state["front"][1][0]).to eq("W")
            expect(cube.state["front"][2][0]).to eq("W")

            expect(cube.state["top"][0][0]).to eq("O")
            expect(cube.state["top"][1][0]).to eq("O")
            expect(cube.state["top"][2][0]).to eq("O")

            expect(cube.state["back"][0][2]).to eq("Y")
            expect(cube.state["back"][1][2]).to eq("Y")
            expect(cube.state["back"][2][2]).to eq("Y")

            expect(cube.state["bottom"][0][0]).to eq("R")
            expect(cube.state["bottom"][1][0]).to eq("R")
            expect(cube.state["bottom"][2][0]).to eq("R")
        end

        it "rotates cube's right face up" do
            CubesService.rotate_cube(cube.id, "right", "up")
            reloaded_cube

            expect(cube.state["front"][0][2]).to eq("Y")
            expect(cube.state["front"][1][2]).to eq("Y")
            expect(cube.state["front"][2][2]).to eq("Y")

            expect(cube.state["bottom"][0][2]).to eq("O")
            expect(cube.state["bottom"][1][2]).to eq("O")
            expect(cube.state["bottom"][2][2]).to eq("O")

            expect(cube.state["back"][0][0]).to eq("W")
            expect(cube.state["back"][1][0]).to eq("W")
            expect(cube.state["back"][2][0]).to eq("W")

            expect(cube.state["top"][0][2]).to eq("R")
            expect(cube.state["top"][1][2]).to eq("R")
            expect(cube.state["top"][2][2]).to eq("R")
            end

        it "rotates cube's right face down" do
            CubesService.rotate_cube(cube.id, "right", "down")
            reloaded_cube

            expect(cube.state["front"][0][2]).to eq("W")
            expect(cube.state["front"][1][2]).to eq("W")
            expect(cube.state["front"][2][2]).to eq("W")

            expect(cube.state["top"][0][2]).to eq("O")
            expect(cube.state["top"][1][2]).to eq("O")
            expect(cube.state["top"][2][2]).to eq("O")

            expect(cube.state["back"][0][0]).to eq("Y")
            expect(cube.state["back"][1][0]).to eq("Y")
            expect(cube.state["back"][2][0]).to eq("Y")

            expect(cube.state["bottom"][0][2]).to eq("R")
            expect(cube.state["bottom"][1][2]).to eq("R")
            expect(cube.state["bottom"][2][2]).to eq("R")
            end


        it "rotates cube's middle layer along X-axis up" do
            CubesService.rotate_cube(cube.id, "middle-x", "up")
            reloaded_cube

            expect(cube.state["front"][0][1]).to eq("Y")
            expect(cube.state["front"][1][1]).to eq("Y")
            expect(cube.state["front"][2][1]).to eq("Y")

            expect(cube.state["bottom"][0][1]).to eq("O")
            expect(cube.state["bottom"][1][1]).to eq("O")
            expect(cube.state["bottom"][2][1]).to eq("O")

            expect(cube.state["back"][0][1]).to eq("W")
            expect(cube.state["back"][1][1]).to eq("W")
            expect(cube.state["back"][2][1]).to eq("W")

            expect(cube.state["top"][0][1]).to eq("R")
            expect(cube.state["top"][1][1]).to eq("R")
            expect(cube.state["top"][2][1]).to eq("R")
            end

        it "rotates cube's middle layer along X-axis down" do
            CubesService.rotate_cube(cube.id, "middle-x", "down")
            reloaded_cube

            expect(cube.state["front"][0][1]).to eq("W")
            expect(cube.state["front"][1][1]).to eq("W")
            expect(cube.state["front"][2][1]).to eq("W")

            expect(cube.state["top"][0][1]).to eq("O")
            expect(cube.state["top"][1][1]).to eq("O")
            expect(cube.state["top"][2][1]).to eq("O")

            expect(cube.state["back"][0][1]).to eq("Y")
            expect(cube.state["back"][1][1]).to eq("Y")
            expect(cube.state["back"][2][1]).to eq("Y")

            expect(cube.state["bottom"][0][1]).to eq("R")
            expect(cube.state["bottom"][1][1]).to eq("R")
            expect(cube.state["bottom"][2][1]).to eq("R")
        end
        
        it "rotates cube's front face left" do
            CubesService.rotate_cube(cube.id, "front", "left")
            reloaded_cube

            expect(cube.state["left"][0][2]).to eq("W")
            expect(cube.state["left"][1][2]).to eq("W")
            expect(cube.state["left"][2][2]).to eq("W")

            expect(cube.state["bottom"][0][0]).to eq("G")
            expect(cube.state["bottom"][0][1]).to eq("G")
            expect(cube.state["bottom"][0][2]).to eq("G")

            expect(cube.state["right"][0][0]).to eq("Y")
            expect(cube.state["right"][1][0]).to eq("Y")
            expect(cube.state["right"][2][0]).to eq("Y")

            expect(cube.state["top"][2][0]).to eq("B")
            expect(cube.state["top"][2][1]).to eq("B")
            expect(cube.state["top"][2][2]).to eq("B")
        end

        it "rotates cube's front face right" do
            CubesService.rotate_cube(cube.id, "front", "right")
            reloaded_cube

            expect(cube.state["right"][0][0]).to eq("W")
            expect(cube.state["right"][1][0]).to eq("W")
            expect(cube.state["right"][2][0]).to eq("W")

            expect(cube.state["bottom"][0][0]).to eq("B")
            expect(cube.state["bottom"][0][1]).to eq("B")
            expect(cube.state["bottom"][0][2]).to eq("B")

            expect(cube.state["left"][0][2]).to eq("Y")
            expect(cube.state["left"][1][2]).to eq("Y")
            expect(cube.state["left"][2][2]).to eq("Y")

            expect(cube.state["top"][2][0]).to eq("G")
            expect(cube.state["top"][2][1]).to eq("G")
            expect(cube.state["top"][2][2]).to eq("G")
        end

        it "rotates cube's back face left" do
            CubesService.rotate_cube(cube.id, "back", "left")
            reloaded_cube

            expect(cube.state["top"][0][0]).to eq("B")
            expect(cube.state["top"][0][1]).to eq("B")
            expect(cube.state["top"][0][2]).to eq("B")

            expect(cube.state["right"][0][2]).to eq("Y")
            expect(cube.state["right"][1][2]).to eq("Y")
            expect(cube.state["right"][2][2]).to eq("Y")

            expect(cube.state["bottom"][2][0]).to eq("G")
            expect(cube.state["bottom"][2][1]).to eq("G")
            expect(cube.state["bottom"][2][2]).to eq("G")

            expect(cube.state["left"][0][0]).to eq("W")
            expect(cube.state["left"][1][0]).to eq("W")
            expect(cube.state["left"][2][0]).to eq("W")
        end

        it "rotates cube's back face right" do
            CubesService.rotate_cube(cube.id, "back", "right")
            reloaded_cube

            expect(cube.state["top"][0][0]).to eq("G")
            expect(cube.state["top"][0][1]).to eq("G")
            expect(cube.state["top"][0][2]).to eq("G")

            expect(cube.state["left"][0][0]).to eq("Y")
            expect(cube.state["left"][1][0]).to eq("Y")
            expect(cube.state["left"][2][0]).to eq("Y")

            expect(cube.state["bottom"][2][0]).to eq("B")
            expect(cube.state["bottom"][2][1]).to eq("B")
            expect(cube.state["bottom"][2][2]).to eq("B")

            expect(cube.state["right"][0][2]).to eq("W")
            expect(cube.state["right"][1][2]).to eq("W")
            expect(cube.state["right"][2][2]).to eq("W")
        end

        it "rotates cube's middle layer along Z-axis left" do
            CubesService.rotate_cube(cube.id, "middle-z", "left")
            reloaded_cube

            expect(cube.state["top"][1][0]).to eq("B")
            expect(cube.state["top"][1][1]).to eq("B")
            expect(cube.state["top"][1][2]).to eq("B")

            expect(cube.state["right"][0][1]).to eq("Y")
            expect(cube.state["right"][1][1]).to eq("Y")
            expect(cube.state["right"][2][1]).to eq("Y")

            expect(cube.state["bottom"][1][0]).to eq("G")
            expect(cube.state["bottom"][1][1]).to eq("G")
            expect(cube.state["bottom"][1][2]).to eq("G")

            expect(cube.state["left"][0][1]).to eq("W")
            expect(cube.state["left"][1][1]).to eq("W")
            expect(cube.state["left"][2][1]).to eq("W")
            end

        it "rotates cube's middle layer along Z-axis right" do
            CubesService.rotate_cube(cube.id, "middle-z", "right")
            reloaded_cube

            expect(cube.state["top"][1][0]).to eq("G")
            expect(cube.state["top"][1][1]).to eq("G")
            expect(cube.state["top"][1][2]).to eq("G")

            expect(cube.state["left"][0][1]).to eq("Y")
            expect(cube.state["left"][1][1]).to eq("Y")
            expect(cube.state["left"][2][1]).to eq("Y")

            expect(cube.state["bottom"][1][0]).to eq("B")
            expect(cube.state["bottom"][1][1]).to eq("B")
            expect(cube.state["bottom"][1][2]).to eq("B")

            expect(cube.state["right"][0][1]).to eq("W")
            expect(cube.state["right"][1][1]).to eq("W")
            expect(cube.state["right"][2][1]).to eq("W")
        end

    end

end