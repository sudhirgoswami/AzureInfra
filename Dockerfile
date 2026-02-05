# escape=`

FROM mcr.microsoft.com/dotnet/sdk:8.0-windowsservercore-ltsc2022 AS build
ARG PROJECT_PATH=.
WORKDIR /src
COPY . .
RUN dotnet restore "%PROJECT_PATH%"
RUN dotnet publish "%PROJECT_PATH%" -c Release -o /app/publish

FROM mcr.microsoft.com/dotnet/aspnet:8.0-windowsservercore-ltsc2022 AS runtime
WORKDIR /app
COPY --from=build /app/publish .
ENTRYPOINT ["dotnet"]
CMD ["App.dll"]
