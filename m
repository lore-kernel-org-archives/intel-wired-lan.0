From: Jakub Kicinski <kuba@kernel.org>
Date: Tue, 15 Sep 2020 08:58:01 -0700
Subject: [Intel-wired-lan] [PATCH net-next v2 00/10] make
 drivers/net/ethernet W=1 clean
In-Reply-To: <a28498acdf87f11e81d3282d63f18dbe1a3d5329.camel@kernel.org>
References: <20200915014455.1232507-1-jesse.brandeburg@intel.com>
 <a28498acdf87f11e81d3282d63f18dbe1a3d5329.camel@kernel.org>
Message-ID: <20200915085801.475e32f2@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, 14 Sep 2020 21:24:28 -0700 Saeed Mahameed wrote:
> I know Jakub and Dave do some compilation testing before merging but i
> don't know how much driver coverage they have and if they use a
> specific .config or they just manually create one on demand..

allmodconfig, it should be able to catch everything that builds on x86
and for a given GCC version.

The other advantage of this series is that we won't have to apply a
thousand single-warning fixes.
