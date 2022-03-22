with Ada.Text_IO; use Ada.Text_IO;
--with Ada.Text_IO;

procedure Adaray is

    subtype Uint8 is Integer range 0..255;
    type RGB is (Red, Green, Blue);
    type Pixel is array(RGB) of Float;

    type FrameBuffer_Type is array(Natural range <>, Natural range <>) of Pixel;


    function Natural_String(Input : String) return String is
        new_string : String := Input(Input'First + 1..Input'Last);
    begin
        return new_string;
    end Natural_String;


    function Pixel_Image(P : Pixel) return String is
        R : Uint8 := Uint8'Max(0, Uint8'Min(255, Uint8(P(Red))));
        G : Uint8 := Uint8'Max(0, Uint8'Min(255, Uint8(P(Green))));
        B : Uint8 := Uint8'Max(0, Uint8'Min(255, Uint8(P(Blue))));
    begin
        return Uint8'Image(R) & Uint8'Image(G) & Uint8'Image(B); 
    end Pixel_Image;


    width : constant Natural := 256;
    width_f : constant Float := Float(width);
    height : constant Natural := 256;
    height_f : constant Float := Float(height);

    framebuffer : FrameBuffer_Type
        (Natural'First..width, 
         Natural'First..height) := (
            others => (others => Pixel'(222.0, 0.0, 0.0)));

    File_Name : constant String := "ray_tracing.ppm";
    F : File_Type;
begin
    Create(F, Out_File, File_Name);

    -- Create Header for the PPM file format
    Put_Line(F, "P3");
    Put_Line(F, Natural_String(width'Image) & " " & Natural_String(height'Image));
    Put_Line(F, "255");

    for j in framebuffer'Range(2) loop
        for i in framebuffer'Range(1) loop
            Put(F, Pixel_Image(framebuffer(j,i)));    
        end loop;
        New_Line(F);
    end loop;

    Close(F);

end Adaray;
