From: Jakub Kicinski <kuba@kernel.org>
Date: Thu, 4 Nov 2021 11:08:55 -0700
Subject: [Intel-wired-lan] [PATCH net-next 6/6] docs: net: Add
 description of SyncE interfaces
In-Reply-To: <20211104081231.1982753-7-maciej.machnikowski@intel.com>
References: <20211104081231.1982753-1-maciej.machnikowski@intel.com>
 <20211104081231.1982753-7-maciej.machnikowski@intel.com>
Message-ID: <20211104110855.3ead1642@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu,  4 Nov 2021 09:12:31 +0100 Maciej Machnikowski wrote:
> +Synchronous Ethernet networks use a physical layer clock to syntonize
> +the frequency across different network elements.
> +
> +Basic SyncE node defined in the ITU-T G.8264 consist of an Ethernet
> +Equipment Clock (EEC) and can recover synchronization
> +from the synchronization inputs - either traffic interfaces or external
> +frequency sources.
> +The EEC can synchronize its frequency (syntonize) to any of those sources.
> +It is also able to select a synchronization source through priority tables
> +and synchronization status messaging. It also provides necessary
> +filtering and holdover capabilities.
> +
> +The following interface can be applicable to diffferent packet network types
> +following ITU-T G.8261/G.8262 recommendations.

Can we get a diagram in here in terms of how the port feeds its
recovered Rx freq into EEC and that feeds freq of Tx on other ports?

I'm still struggling to understand your reasoning around not making 
EEC its own object. "We can do this later" seems like trading
relatively little effort now for extra work for driver and application
developers for ever.

Also patch 3 still has a kdoc warning.
