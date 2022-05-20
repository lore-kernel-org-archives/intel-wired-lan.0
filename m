From: Jakub Kicinski <kuba@kernel.org>
Date: Fri, 20 May 2022 15:34:13 -0700
Subject: [Intel-wired-lan] [PATCH net-next v5 00/11] ethtool: Add
 support for frame preemption
In-Reply-To: <20220520011538.1098888-1-vinicius.gomes@intel.com>
References: <20220520011538.1098888-1-vinicius.gomes@intel.com>
Message-ID: <20220520153413.16c6830b@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, 19 May 2022 18:15:27 -0700 Vinicius Costa Gomes wrote:
> Changes from v4:
>  - Went back to exposing the per-queue frame preemption bits via
>    ethtool-netlink only, via taprio/mqprio was seen as too much
>    trouble. (Vladimir Oltean)
>  - Fixed documentation and code/patch organization changes (Vladimir
>    Oltean).

First of all - could you please, please, please rev these patches more
than once a year? It's really hard to keep track of the context when
previous version was sent in Jun 2021 :/

I disagree that queue mask belongs in ethtool. It's an attribute of 
a queue and should be attached to a queue. The DCBNL parallel is flawed
IMO because pause generation is Rx, not Tx. There is no Rx queue in
Linux, much less per-prio.
