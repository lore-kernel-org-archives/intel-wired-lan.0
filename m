From: Jakub Kicinski <kuba@kernel.org>
Date: Mon, 18 Jan 2021 10:32:33 -0800
Subject: [Intel-wired-lan] [PATCH net-next 0/4] i40e: small improvements
 on XDP path
In-Reply-To: <CAJ8uoz3YSuPj6F+GHkk6yXHryUEOUhVSg2pDVEVrFA6b8Hgu6g@mail.gmail.com>
References: <20210114143318.2171-1-cristian.dumitrescu@intel.com>
 <CAJ8uoz3YSuPj6F+GHkk6yXHryUEOUhVSg2pDVEVrFA6b8Hgu6g@mail.gmail.com>
Message-ID: <20210118103233.49bfd205@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, 18 Jan 2021 08:31:23 +0100 Magnus Karlsson wrote:
> On Thu, Jan 14, 2021 at 3:34 PM Cristian Dumitrescu
> <cristian.dumitrescu@intel.com> wrote:
> >
> > This patchset introduces some small and straightforward improvements
> > to the Intel i40e driver XDP path. Each improvement is fully described
> > in its associated patch.
> 
> Thank you for these clean ups Cristian!
> 
> For the series:
> 
> Acked-by: Magnus Karlsson <magnus.karlsson@intel.com>

FWIW since this series is 100% driver code I'm expecting it will 
come downstream via Tony's tree. Please LMK if that's not the case.
