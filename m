From: Ido Schimmel <idosch@idosch.org>
Date: Wed, 27 Oct 2021 09:50:08 +0300
Subject: [Intel-wired-lan] [RFC v5 net-next 0/5] Add RTNL interface for
 SyncE
In-Reply-To: <20211026173146.1031412-1-maciej.machnikowski@intel.com>
References: <20211026173146.1031412-1-maciej.machnikowski@intel.com>
Message-ID: <YXj2oKjjobd0ZgBi@shredder>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, Oct 26, 2021 at 07:31:41PM +0200, Maciej Machnikowski wrote:
> Synchronous Ethernet networks use a physical layer clock to syntonize
> the frequency across different network elements.
> 
> Basic SyncE node defined in the ITU-T G.8264 consist of an Ethernet
> Equipment Clock (EEC) and have the ability to recover synchronization
> from the synchronization inputs - either traffic interfaces or external
> frequency sources.
> The EEC can synchronize its frequency (syntonize) to any of those sources.
> It is also able to select synchronization source through priority tables
> and synchronization status messaging. It also provides neccessary
> filtering and holdover capabilities
> 
> This patch series introduces basic interface for reading the Ethernet
> Equipment Clock (EEC) state on a SyncE capable device. This state gives
> information about the source of the syntonization signal (ether my port,
> or any external one) and the state of EEC. This interface is required\
> to implement Synchronization Status Messaging on upper layers.
> 
> v2:
> - removed whitespace changes
> - fix issues reported by test robot
> v3:
> - Changed naming from SyncE to EEC
> - Clarify cover letter and commit message for patch 1
> v4:
> - Removed sync_source and pin_idx info
> - Changed one structure to attributes
> - Added EEC_SRC_PORT flag to indicate that the EEC is synchronized
>   to the recovered clock of a port that returns the state
> v5:
> - add EEC source as an optiona attribute
> - implement support for recovered clocks
> - align states returned by EEC to ITU-T G.781

Hi,

Thanks for continuing to work on this.

I was under the impression (might be wrong) that the consensus last time
was to add a new ethtool message to query the mapping between the port
and the EEC clock (similar to TSINFO_GET) and then use a new generic
netlink family to perform operations on the clock itself.

At least in the case of RTM_GETEECSTATE and a multi-port adapter, you
would actually query the same state via each netdev, but without
realizing it's the same clock.

I think another reason to move to ethtool was that this stuff is
completely specific to Ethernet and not applicable to all logical
netdevs.
