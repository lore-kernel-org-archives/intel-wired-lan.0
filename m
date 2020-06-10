From: Andre Guedes <andre.guedes@intel.com>
Date: Wed, 10 Jun 2020 11:40:38 -0700
Subject: [Intel-wired-lan] [PATCH v2 1/1] igc: Remove unneeded check for
 copper media type
In-Reply-To: <20200610124308.41422-1-sasha.neftin@intel.com>
References: <20200610124308.41422-1-sasha.neftin@intel.com>
Message-ID: <159181443856.78170.15999671258648186100@camachog-mobl.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi Sasha,

> PHY of the i225 device support only copper mode.
> There is no point to check media type in the
> igc_power_up_link() method.

A quick grep shows that we have many checks like this in the igc code. How
about we extend this patch to remove all of them at once?

Regards,

Andre
