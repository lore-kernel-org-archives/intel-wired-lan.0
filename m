From: Jesse Brandeburg <jesse.brandeburg@intel.com>
Date: Tue, 18 Feb 2020 09:45:55 -0800
Subject: [Intel-wired-lan] [PATCH v1 1/1] e1000e: Fix typo in Alder Lake
 brand name
In-Reply-To: <20200217060718.20965-1-sasha.neftin@intel.com>
References: <20200217060718.20965-1-sasha.neftin@intel.com>
Message-ID: <20200218094555.00001cb4@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, 17 Feb 2020 08:07:18 +0200 Sasha wrote:
> -#define E1000_DEV_ID_PCH_ADP_1219_LM16		0x1A1E
                                ^
                                ^^^
Man this change is so subtle, you should definitely mention in your
commit message that you're changing a "one" to an "I"

I wrote a whole response to this mail without seeing the difference
until the end.
