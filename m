From: Alexander Lobakin <alexandr.lobakin@intel.com>
Date: Fri,  4 Feb 2022 13:05:37 +0100
Subject: [Intel-wired-lan] [PATCH net-next 00/19] Add iecm and idpf
In-Reply-To: <20220128001009.721392-1-alan.brady@intel.com>
References: <20220128001009.721392-1-alan.brady@intel.com>
Message-ID: <20220204120537.80979-1-alexandr.lobakin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Alan Brady <alan.brady@intel.com>
Date: Thu, 27 Jan 2022 16:09:50 -0800

> This series introduces both the Intel Ethernet Common Module and the
> Intel Data Plane Function.  This also adds extended features and
> functionality to virtchnl with virtchnl_2.h.
>  
> The format of the series generally follows the flow of driver init to
> interface open. We go from probe into a hard reset followed by an init
> task. From there the rest of the netdev_ops and data path are added.
> Then lastly advanced features and idpf are introduced.
> 
> Currently this common layer (iecm) is initially only being used by only
> the idpf driver (PF driver for SmartNIC).  However, the plan is to
> eventually switch our iavf driver along with future drivers to use this
> common module.  The hope is to better enable code sharing going forward
> as well as support other developers writing drivers for our hardware

                                                                      ^

There's a dot '.' missing.

> 
> Alan Brady (17):
>   virtchnl: Add new virtchnl2 ops
>   iecm: add basic module init and documentation
>   iecm: add probe and remove
>   iecm: add api_init and controlq init
>   iecm: add vport alloc and virtchnl messages
>   iecm: add virtchnl messages for queues
>   iecm: finish virtchnl messages
>   iecm: add interrupts and configure netdev
>   iecm: alloc vport TX resources
>   iecm: alloc vport RX resources
>   iecm: add start_xmit and set_rx_mode
>   iecm: finish netdev_ops
>   iecm: implement splitq napi_poll
>   iecm: implement singleq napi_poll
>   iecm: implement ethtool callbacks
>   iecm: implement cloud filters
>   idpf: introduce idpf driver
> 
> Haiyue Wang (2):
>   iecm: implement flow director
>   iecm: add advanced rss

I'd like to remind here that you can *not* proceed with publishing
a v2 to netdev ML before at least me *and* Shannon (we're the only
two for now who did reviews here) say "I'm okay with your vN
revision".
I'm doing this because this is what you did previously, transferring
from our internal ML to IWL. In fact, you changed a bunch of code
and the authorship of two patches, but didn't publish a v2 there
and went directly here instead, without even providing a changelog,
so I only realized there were other changes apart from the authors
only when started comparing those two submissions.
Incorporating only the changes marked by you as "will fix" and not
getting the others resolved (places you didn't explain or answer to,
questionable "won't fix" which the reviewers disagree with etc.)
doesn't make this series ready for netdev ML.
And please supply changelogs at the end of the cover letter for each
subsequent revision, so people could easily see what was addressed
and what was not.

> 
>  .../device_drivers/ethernet/intel/idpf.rst    |   47 +
>  .../device_drivers/ethernet/intel/iecm.rst    |   93 +
>  MAINTAINERS                                   |    1 +
>  drivers/net/ethernet/intel/Kconfig            |   31 +
>  drivers/net/ethernet/intel/Makefile           |    2 +
>  drivers/net/ethernet/intel/idpf/Makefile      |   15 +
>  drivers/net/ethernet/intel/idpf/idpf_dev.h    |   17 +
>  drivers/net/ethernet/intel/idpf/idpf_devids.h |   10 +
>  drivers/net/ethernet/intel/idpf/idpf_main.c   |  140 +
>  drivers/net/ethernet/intel/idpf/idpf_reg.c    |  130 +
>  drivers/net/ethernet/intel/iecm/Makefile      |   21 +
>  .../net/ethernet/intel/iecm/iecm_controlq.c   |  649 ++
>  .../ethernet/intel/iecm/iecm_controlq_setup.c |  175 +
>  .../net/ethernet/intel/iecm/iecm_ethtool.c    | 1332 ++++
>  drivers/net/ethernet/intel/iecm/iecm_lib.c    | 5717 +++++++++++++++++
>  drivers/net/ethernet/intel/iecm/iecm_main.c   |   40 +
>  .../ethernet/intel/iecm/iecm_singleq_txrx.c   | 1229 ++++
>  drivers/net/ethernet/intel/iecm/iecm_txrx.c   | 4577 +++++++++++++
>  .../net/ethernet/intel/iecm/iecm_virtchnl.c   | 4240 ++++++++++++
>  drivers/net/ethernet/intel/include/iecm.h     |  973 +++
>  .../ethernet/intel/include/iecm_controlq.h    |  117 +
>  .../intel/include/iecm_controlq_api.h         |  185 +
>  .../ethernet/intel/include/iecm_lan_pf_regs.h |  131 +
>  .../ethernet/intel/include/iecm_lan_txrx.h    |  394 ++
>  drivers/net/ethernet/intel/include/iecm_mem.h |   20 +
>  .../net/ethernet/intel/include/iecm_txrx.h    |  733 +++
>  include/linux/avf/virtchnl.h                  | 1507 ++++-
>  include/linux/avf/virtchnl_2.h                | 1243 ++++
>  include/linux/avf/virtchnl_lan_desc.h         |  603 ++

--- 8< ---

> -- 
> 2.33.0

Thanks,
Al
