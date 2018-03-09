From: David Miller <davem@davemloft.net>
Date: Fri, 09 Mar 2018 13:23:07 -0500 (EST)
Subject: [Intel-wired-lan] [PATCH 00/15] Add ice driver
In-Reply-To: <20180309172136.9073-1-anirudh.venkataramanan@intel.com>
References: <20180309172136.9073-1-anirudh.venkataramanan@intel.com>
Message-ID: <20180309.132307.1880314193679862945.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Date: Fri,  9 Mar 2018 09:21:21 -0800

> This patch series adds the ice driver, which will support the Intel(R)
> E800 Series of network devices.
> 
> This is the first phase in the release of this driver where we implement
> basic transmit and receive. The idea behind the multi-phase release is to
> aid in code review as well as testing. Subsequent phases will implement
> advanced features (like SR-IOV, tunnelling, flow director, QoS, etc.) that
> build upon the previous phase(s). Each phase will be submitted as a patch
> series.
> 
> I cc'd netdev for review since this is a new driver, even though this is
> targetted to go through Jeff Kirsher's Intel Wired LAN git tree(s).

I did a quick once-over on this driver and I have no major objections.
