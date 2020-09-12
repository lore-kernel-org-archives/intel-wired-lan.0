From: Jesse Brandeburg <jesse.brandeburg@intel.com>
Date: Fri, 11 Sep 2020 17:49:39 -0700
Subject: [Intel-wired-lan] [RFC PATCH net-next v1 11/11]
 drivers/net/ethernet: clean up mis-targeted comments
In-Reply-To: <115bce2a-daaa-a7c5-3c48-44ce345ea008@solarflare.com>
References: <20200911012337.14015-1-jesse.brandeburg@intel.com>
 <20200911012337.14015-12-jesse.brandeburg@intel.com>
 <227d2fe4-ddf8-89c9-b80b-142674c2cca0@solarflare.com>
 <20200911144207.00005619@intel.com>
 <e2e637ae-8cda-c9a4-91ce-93dbd475fc0c@solarflare.com>
 <20200911152642.62923ba2@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <115bce2a-daaa-a7c5-3c48-44ce345ea008@solarflare.com>
Message-ID: <20200911174939.00001817@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Edward Cree wrote:

> On 11/09/2020 23:26, Jakub Kicinski wrote:
> > #declare _MCDI_BUF_LEN(_len)   DIV_ROUND_UP(_len, 4)
> >
> > 	efx_dword_t txbuf[_MCDI_BUF_LEN(MC_CMD_PTP_IN_TRANSMIT_LENMAX)];
> >
> > Would that work?
> That could work, yes.? Though, probably lose the leading underscore
> ?in that case.

Ok, I made a split-out patch for that change in v2, it seems to work
once I found a name that didn't collide.

Thanks for the useful discussion!
