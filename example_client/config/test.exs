import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :example_client, ExampleClient.Repo,
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  database: "example_client_test#{System.get_env("MIX_TEST_PARTITION")}",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :example_client, ExampleClientWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "M2Bz4twIbgf3rN6qpAJiBV7hrqZRDiYOhk2FD4o30Y5W+j0ZbtHjzYhxS71dVFVh",
  server: false

# In test we don't send emails.
config :example_client, ExampleClient.Mailer, adapter: Swoosh.Adapters.Test

# Disable swoosh api client as it is only required for production adapters.
config :swoosh, :api_client, false

# Print only warnings and errors during test
config :logger, level: :warning

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime

config :example_client, :sso,
  public_key: %{
    jwk: %{
      "d" =>
        "JiAWENj3_mdWG8LRjeVSil-JswXlTWLY0vXIscgCz7kKXxh0fQEoBPlmNnr2J5phrYyIbEtnsBapZzSxUnVpyszDiIqFSzxj8H65KYD1zNJmc18PwdZ5UT0Rb_2EuzrN_M8qez4sxF_Vrch29F_KAbPtZbhxZazQW_le59hzqh_m5NiY28wY7vHFWb5B2OoUzO86VZfkb75gQ-fIbgFPwMDTsfXDEJsPSFwLByUgjMk95fznt6R0ceCe2U4NyKp3dDxp3-bdjmaTRcEGp-4d-AmHUditKUWEic1YNbAF88onRSo0N7A2URJNYwTTArZKkbyTqgp4rF190sNrqHy34TIjaBA4RBCp6eKzs6OAVF195H0NNNEbt11_kgtyVKEQ9PdJY-3eQa4VZzW1dIlpk5nERo1Lh6KyofcVP07B61gCV0SNoSxv2Xr7CyvLK_9TM-wXIy31HzeuNPfPFZ8WSqj6vxorYSaBdlxHdt8Fy9fzOdo-MnhqlaPffNcMT-jwIL8YX_oVgXHfPk5adyiQ9F3aDdTTTPsxsuvfVHgx7Py8flJPAdnamVm9kV9BpkA_GfMMqYKEU1QckbypXt3HW5z9Bdi3KNADCEEUR_4NHSiZxFHve_z23gfglifm4pptkez57QMewSpKq1DHfnxUrpfMHNZGWjNC6mnApm0Ea3E",
      "dp" =>
        "0u923nc6HP4JCODdY4K2WOEaFsHjjWc4-iXTXWrU79ahpLRYUIW31yxO7D5wUwY--fbmeO_3G6kL0MOfFSyvFId6z03DLCqrEGek7sG5QQ55o0GitUmAYKFp5kg43Mn0c65f1v9UzdwLtcb9o87OtJOakD1Ft1WyPp7RWJ8MntiEVymNGqcVK9QLW9Nd1JGok-ia88XpgOrjt1-nhxIJIoOjeGDCB88732MKjwPmwne3_Bgse1pY8BCuc5w-kLigRg5kDliPo2Dqstjam-9Rrsikci_6uhRBQIkvn611QrxYhML3O0lsbAkLGHSjS9hSjLA3xmIlCUIweJ4m_nWa1Q",
      "dq" =>
        "vc9N4OPBSH80OP-g0HF9QRT-49cuzbhd2G8PO8VMufN1oWU5mt1kH8xlX_wloLtL2cDkjq4I429crlsTH1H5ycJwqj0PDenxSMtcwzbZkecaOCdVdiyNGsXdwuUvVGjxLS1Lz-QYa6-421cr_pwEg0vvlWS501-RNv1rLoqcgzGlu2J2NGrVxrYf5oB_WCTGXk73EUE3aiMfXtY3flR7Hgd5hWZVvdYbasx2hESA1DbqHqDg-nFmbfYIhEPkgCjZpaaGQXbXZFxGGBnAHg9bVVn6DNvH7UP6VYR4_FTFwUTGklfFnhUhaZH1A8OGQk7gImeYNg53lr8HA_UysPgAfQ",
      "e" => "AQAB",
      "kty" => "RSA",
      "n" =>
        "6x64BMtuxdsPFRnIkCAAYMs4skDPDoeUy_UBv4FNlgzqDsNCmDzTp3saLrbCRaG-hdjID1Eb9K-yef3w5kQVTOIc5AiGE6ZFQTn5sanjFlX7dzUlDB9keIFgmcNDcdw7cZw0MBk_AermGDB8azdwdkc8PVQG_SNvxUNaAP8Md9v8jJMVeStnJxDxLFbnxR-TF2REbyegygjp0f10XyXKbSPIqT2GgEGFXrpj88QndObXxqNR_XNd-0GEXtadwYSFCiN2aGwNhUpz-aXFMj7SvUiprAYL8npe2TBZG68-OAjwTR9HCZ9BoHnCgcy88pC2gNvTvPxtiAmwRQXEfxsPvGUjV8_ADuwGmITKimQvr5Se463kyIDPt6SPeNgc5_EJ_dHkuDUmanqJmiY9edLNykjBkSQK-KCHmAExXziWmiwxV_v7CrSD0lo22DKg70CmclaVajAMyKetjzdfwvMd4lOxXmJLLDS_jDFP-rwJlsqOwS2n6dnCtHAf2UFagSPRZWlvFqQN079u_XjGzTDIFZtfro3AxdC70jbjWQ2VxEdXnvU-gyAuduZ8eLDhbLmPv2jZiEIu5xo5xlrhiv7PUoxwKugxQaYbGIoGVbhU8_S0OOZBv0UHZxZ_FYxO3vRb2GEAvcGnhHqT6XOeuCo7Z5vBiIufmWFnfbUusA1Zxtk",
      "p" =>
        "-tculgoZ7iwqmbevatWyHf72x1e-ezGK4g5qlaZUzitT5xLvDcXowBs6_diodZJpQFIz9cq9GmiUNTslcGqsQgKujPJI90yBzONI_c5OVvv1EGOxyfWE2QydNbGwD7H3hohaJCnXwB-hsWNtWw1UUifqpmrIcSKScfNy1wbbfjzgNivl6eYuazT3ERVq0x7hvBV0lOQaNj-FYMUZSXrcbzpBSIavGQLFjX3Sz-IAHPqSZ9bA6We0bMwjmhj0ZW2d4OroJCRtZxyGvvq-aMHvIRRr1juLyZKMIUCN_2HwQPcs5DSe1pA_8WJBWI8WtARlawYOB_1EFNzNYqSh4LQgjQ",
      "q" =>
        "7_TCWQsbWAuPEyUCvbTb9YW9kN8jvfZte7sAjV9sPv4HENktEjjLPdBQGV63nZi50aJanQl0WINbJwPsW55UDmuskWNvwrtmW3LGncXXj1-WwQBg2t6yxL3iqT7wK9AWeCNm1-gPrrzyesXosNOHAuQbzHJsbtbc6sEQVJH3wxzyfUNCyIZUSFV7nE9gH_DSlD2insOGhIYHkKluMrcGnV9rDJYyATvaGVodB7u4ZmWR74f7CemsgxTMCXu604dM1eckCKg34F_QD-FiZvBJ5ft2u5Ijqy5xCtBLdZTrx0NSRUZBV1rnhmElja8SwmHRTRGbjkbzMQErTsefwXnqfQ",
      "qi" =>
        "JyNwHH_DQX38J9F_KicIcGOzC65ZYA74Zs1pPU-FUZa0pmoFxDyX0ARpKnSBzf9c7L8RwZlrlgqdMkEf2TZR5MyQQtQOtKOKkjGhFczaYSHEoyT8KKpt1LiUYZkS2-M9XCAS_tXV3-gAt-t4LWaIWgCjW-g7-YbBXvrE34fo0now212iBD19v0WV6DK-aVgXvUpQ6OWAA5QUrPpho-_RHovUf7ZnjXs7KX-5Flr8Ybxh6kDTPgoBxt2f4e_C8rsnHTFdS5nkMKpd-ZrqPgl4tHAoC5TfAFnm0EOTcpBS9qtU5dgz4H_t28URP3jiyc06tQewiB6EvIZRi9qdAuR2aQ"
    },
    jws: %{
      alg: {:jose_jws_alg_rsa_pkcs1_v1_5, :RS256},
      b64: :undefined,
      fields: %{"typ" => "JWT"}
    },
    alg: "RS256"
  }

config :joken,
  default_signer: [
    signer_alg: "RS256",
    key_pem: """
    -----BEGIN PRIVATE KEY-----
    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
    ET944snNOrUHsIgehLyGUYvanQLkdmk=
    -----END PRIVATE KEY-----
    """
  ]
