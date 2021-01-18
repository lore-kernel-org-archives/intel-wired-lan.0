From: Magnus Karlsson <magnus.karlsson@gmail.com>
Date: Mon, 18 Jan 2021 08:31:23 +0100
Subject: [Intel-wired-lan] [PATCH net-next 0/4] i40e: small improvements
 on XDP path
In-Reply-To: <20210114143318.2171-1-cristian.dumitrescu@intel.com>
References: <20210114143318.2171-1-cristian.dumitrescu@intel.com>
Message-ID: <CAJ8uoz3YSuPj6F+GHkk6yXHryUEOUhVSg2pDVEVrFA6b8Hgu6g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, Jan 14, 2021 at 3:34 PM Cristian Dumitrescu
<cristian.dumitrescu@intel.com> wrote:
>
> This patchset introduces some small and straightforward improvements
> to the Intel i40e driver XDP path. Each improvement is fully described
> in its associated patch.
>
> Cristian Dumitrescu (4):
>   i40e: remove unnecessary memory writes of the next to clean pointer
>   i40e: remove unnecessary cleaned_count updates
>   i40e: remove the redundant buffer info updates
>   i40: consolidate handling of XDP program actions
>
>  drivers/net/ethernet/intel/i40e/i40e_xsk.c | 149 +++++++++++----------
>  1 file changed, 79 insertions(+), 70 deletions(-)
>
> --
> 2.25.1
>

Thank you for these clean ups Cristian!

For the series:

Acked-by: Magnus Karlsson <magnus.karlsson@intel.com>
