From: Heiner Kallweit <hkallweit1@gmail.com>
Date: Tue, 18 Feb 2020 19:54:19 +0100
Subject: [Intel-wired-lan] [PATCH net-next 3/3] net: use new helper
 tcp_v6_gso_csum_prep
In-Reply-To: <CAKgT0UdP78GGnowWC85YiTAHOr63NiLa25=2TSckKBEzGBdeJA@mail.gmail.com>
References: <76cd6cfc-f4f3-ece7-203a-0266b7f02a12@gmail.com>
 <9270ae4b-feb1-6a4d-8a22-fbe5e47b7617@gmail.com>
 <CAKgT0UdP78GGnowWC85YiTAHOr63NiLa25=2TSckKBEzGBdeJA@mail.gmail.com>
Message-ID: <e6b59cad-b6a6-73fc-7d75-3cc9ce6411ab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 18.02.2020 19:34, Alexander Duyck wrote:
> On Mon, Feb 17, 2020 at 1:43 PM Heiner Kallweit <hkallweit1@gmail.com> wrote:
>>
>> Use new helper tcp_v6_gso_csum_prep in additional network drivers.
>>
>> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
>> ---
>>  drivers/net/ethernet/atheros/alx/main.c       |  5 +---
>>  .../net/ethernet/atheros/atl1c/atl1c_main.c   |  6 ++---
>>  drivers/net/ethernet/brocade/bna/bnad.c       |  7 +----
>>  drivers/net/ethernet/cisco/enic/enic_main.c   |  3 +--
>>  drivers/net/ethernet/intel/e1000/e1000_main.c |  6 +----
>>  drivers/net/ethernet/intel/e1000e/netdev.c    |  5 +---
>>  drivers/net/ethernet/jme.c                    |  7 +----
>>  .../net/ethernet/pensando/ionic/ionic_txrx.c  |  5 +---
>>  drivers/net/ethernet/qualcomm/emac/emac-mac.c |  7 ++---
>>  drivers/net/ethernet/socionext/netsec.c       |  6 +----
>>  drivers/net/hyperv/netvsc_drv.c               |  5 +---
>>  drivers/net/usb/r8152.c                       | 26 ++-----------------
>>  drivers/net/vmxnet3/vmxnet3_drv.c             |  5 +---
>>  13 files changed, 16 insertions(+), 77 deletions(-)
>>
> 
> It might make sense to break this up into several smaller patches
> based on the maintainers for the various driver bits.
> 
OK

> So the changes all look fine to me, but I am not that familiar with
> the non-Intel drivers.
> 
> Reviewed-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> 

