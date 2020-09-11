From: Jesse Brandeburg <jesse.brandeburg@intel.com>
Date: Fri, 11 Sep 2020 14:42:07 -0700
Subject: [Intel-wired-lan] [RFC PATCH net-next v1 11/11]
 drivers/net/ethernet: clean up mis-targeted comments
In-Reply-To: <227d2fe4-ddf8-89c9-b80b-142674c2cca0@solarflare.com>
References: <20200911012337.14015-1-jesse.brandeburg@intel.com>
 <20200911012337.14015-12-jesse.brandeburg@intel.com>
 <227d2fe4-ddf8-89c9-b80b-142674c2cca0@solarflare.com>
Message-ID: <20200911144207.00005619@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Edward Cree wrote:
> On 11/09/2020 02:23, Jesse Brandeburg wrote:
> > + * @MC_CMD_PTP_IN_TRANSMIT_LENMAX: hack to get W=1 to compile

> I think I'd rather have a bogus warning than bogus kerneldocto suppress it;
> ?please drop this line (and encourage toolchain folks to figure out how to
> ?get kerneldoc to ignore macros it can't understand).
> Apart from that, the sfc and sfc/falcon parts LGTM.
> 
> -ed

Thanks Ed, I think I might just remove the /** on that function then
(removing it from kdoc processing), would that be acceptable in the
meantime? Of course I'd remove the line I added as well.

- Jesse

