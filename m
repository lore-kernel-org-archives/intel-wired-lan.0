From: Limonciello, Mario <Mario.Limonciello@dell.com>
Date: Tue, 15 Dec 2020 17:20:18 +0000
Subject: [Intel-wired-lan] Fw: [External] Re: [PATCH v4 0/4] Improve
 s0ix flows for systems i219LM
In-Reply-To: <18c1c152-9298-a4c5-c4ed-92c9fd91ea8a@intel.com>
References: <20201214153450.874339-1-mario.limonciello@dell.com>
 <80862f70-18a4-4f96-1b96-e2fad7cc2b35@redhat.com>
 <PS2PR03MB37505A15D3C9B7505D679D7BBDC70@PS2PR03MB3750.apcprd03.prod.outlook.com>
 <ae436f90-45b8-ba70-be57-d17641c4f79d@lenovo.com>
 <18c1c152-9298-a4c5-c4ed-92c9fd91ea8a@intel.com>
Message-ID: <DM6PR19MB2636FA6E479914432036987BFAC60@DM6PR19MB2636.namprd19.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


> > Absolutely - I'll ask them to look into this again.
> >
> we need to explain why on Windows systems required 1s and on Linux
> systems up to 2.5s - otherwise it is not reliable approach - you will
> encounter others buggy system.
> (ME not POR on the Linux systems - is only one possible answer)

Sasha: In your opinion does this information need to block the series?
or can we follow up with more changes later on as more information becomes
available?

For now v5 of the series extends the timeout but at least makes a mention
that there appears to be a firmware bug when more than 1 second is taken.
