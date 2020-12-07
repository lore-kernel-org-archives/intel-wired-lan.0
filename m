From: Jakub Kicinski <kuba@kernel.org>
Date: Mon, 7 Dec 2020 15:22:07 -0800
Subject: [Intel-wired-lan] [PATCH net-next v1 6/9] igc: Add support for
 tuning frame preemption via ethtool
In-Reply-To: <87a6up1cw2.fsf@intel.com>
References: <20201202045325.3254757-1-vinicius.gomes@intel.com>
 <20201202045325.3254757-7-vinicius.gomes@intel.com>
 <20201205100030.2e3c5dd2@kicinski-fedora-pc1c0hjn.DHCP.thefacebook.com>
 <87a6up1cw2.fsf@intel.com>
Message-ID: <20201207152207.0c0d6edd@kicinski-fedora-pc1c0hjn.DHCP.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, 07 Dec 2020 14:15:25 -0800 Vinicius Costa Gomes wrote:
> > WARNING: 'PREEMPTABLE' may be misspelled - perhaps 'PREEMPTIBLE'?  
> 
> In the datasheet the term PREEMPTABLE is used, and when refering to
> register values I chose to be consistent with the datasheet. But as the
> margin for confusion is small, I can change to use "preemptible"
> everywhere, no problem.

If there is a reason to it feel free to keep as is.
