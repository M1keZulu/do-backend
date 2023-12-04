from pydantic import BaseModel
from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware

app = FastAPI(title='Calculator App', description='An app for basic calculations', version='1.0')

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)


@app.post("/calculate")
def calculate(data: dict):
    try:
        number1 = data.get("number1")
        number2 = data.get("number2")
        operation = data.get("operation")

        number1 = float(number1)
        number2 = float(number2)

        if number1 is None or number2 is None or operation is None:
            return {"result": "Invalid data"}

        if operation not in ["+", "-", "*", "/"]:
            return {"result": "Invalid operation"}

        if operation == "+":
            result = number1 + number2
        elif operation == "-":
            result = number1 - number2
        elif operation == "*":
            result = number1 * number2
        elif operation == "/":
            result = number1 / number2 if number2 != 0 else "Cannot divide by zero"
        else:
            result = "Invalid operation"

        return {"result": result}
    except Exception as e:
        return {"result": "Error occurred"}

if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=8000)
