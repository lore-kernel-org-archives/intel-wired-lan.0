From: Andre Guedes <andre.guedes@intel.com>
Date: Tue, 19 May 2020 15:40:14 -0700
Subject: [Intel-wired-lan] [next-queue RFC 0/4] ethtool: Add support for
 frame preemption
In-Reply-To: <87sgfxox4x.fsf@intel.com>
References: <20200516012948.3173993-1-vinicius.gomes@intel.com>
 <20200516093317.GJ21714@lion.mk-sys.cz> <87sgfxox4x.fsf@intel.com>
Message-ID: <158992801438.36166.9692784713665851855@twxiong-mobl.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi,

Quoting Vinicius Costa Gomes (2020-05-18 12:34:22)
> Hi,
> 
> Michal Kubecek <mkubecek@suse.cz> writes:
> 
> > On Fri, May 15, 2020 at 06:29:44PM -0700, Vinicius Costa Gomes wrote:
> >> Hi,
> >> 
> >> This series adds support for configuring frame preemption, as defined
> >> by IEEE 802.1Q-2018 (previously IEEE 802.1Qbu) and IEEE 802.3br.
> >> 
> >> Frame preemption allows a packet from a higher priority queue marked
> >> as "express" to preempt a packet from lower priority queue marked as
> >> "preemptible". The idea is that this can help reduce the latency for
> >> higher priority traffic.
> >> 
> >> Previously, the proposed interface for configuring these features was
> >> using the qdisc layer. But as this is very hardware dependent and all
> >> that qdisc did was pass the information to the driver, it makes sense
> >> to have this in ethtool.
> >> 
> >> One example, for retrieving and setting the configuration:
> >> 
> >> $ ethtool $ sudo ./ethtool --show-frame-preemption enp3s0
> >> Frame preemption settings for enp3s0:
> >>      support: supported
> >
> > IMHO we don't need a special bool for this. IIUC this is not a state
> > flag that would change value for a particular device; either the device
> > supports the feature or it does not. If it does not, the ethtool_ops
> > callbacks would return -EOPNOTSUPP (or would not even exist if the
> > driver has no support) and ethtool would say so.
> 
> (I know that the comments below only apply if "ethtool-way" is what's
> decided)
> 
> Cool. Will remove the supported bit.
> 
> >
> >>      active: active
> >>      supported queues: 0xf

Following the same rationale, is this 'supported queue' going aways as well?

- Andre
