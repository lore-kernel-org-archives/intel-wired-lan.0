From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Date: Tue, 19 May 2020 09:43:27 -0700
Subject: [Intel-wired-lan] [next-queue RFC 0/4] ethtool: Add support for
 frame preemption
In-Reply-To: <VE1PR04MB6496D0B1507969D8474F78FC92B90@VE1PR04MB6496.eurprd04.prod.outlook.com>
References: <VE1PR04MB6496D0B1507969D8474F78FC92B90@VE1PR04MB6496.eurprd04.prod.outlook.com>
Message-ID: <87lflnooy8.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Po Liu <po.liu@nxp.com> writes:

> Hi Vinicius,
>
>> -----Original Message-----
>> From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
>> Sent: 2020?5?19? 3:34
>> To: Michal Kubecek <mkubecek@suse.cz>; netdev at vger.kernel.org
>> Cc: intel-wired-lan at lists.osuosl.org; jeffrey.t.kirsher at intel.com; Vladimir
>> Oltean <vladimir.oltean@nxp.com>; Po Liu <po.liu@nxp.com>; m-
>> karicheri2 at ti.com; Jose.Abreu at synopsys.com
>> Subject: Re: [next-queue RFC 0/4] ethtool: Add support for frame
>> preemption
>> 
>> Hi,
>> 
>> Michal Kubecek <mkubecek@suse.cz> writes:
>> 
>> > On Fri, May 15, 2020 at 06:29:44PM -0700, Vinicius Costa Gomes wrote:
>> >> Hi,
>> >>
>> >> This series adds support for configuring frame preemption, as defined
>> >> by IEEE 802.1Q-2018 (previously IEEE 802.1Qbu) and IEEE 802.3br.
>> >>
>> >> Frame preemption allows a packet from a higher priority queue marked
>> >> as "express" to preempt a packet from lower priority queue marked as
>> >> "preemptible". The idea is that this can help reduce the latency for
>> >> higher priority traffic.
>> >>
>> >> Previously, the proposed interface for configuring these features was
>> >> using the qdisc layer. But as this is very hardware dependent and all
>> >> that qdisc did was pass the information to the driver, it makes sense
>> >> to have this in ethtool.
>> >>
>> >> One example, for retrieving and setting the configuration:
>> >>
>> >> $ ethtool $ sudo ./ethtool --show-frame-preemption enp3s0 Frame
>> >> preemption settings for enp3s0:
>> >>      support: supported
>> >
>> > IMHO we don't need a special bool for this. IIUC this is not a state
>> > flag that would change value for a particular device; either the
>> > device supports the feature or it does not. If it does not, the
>> > ethtool_ops callbacks would return -EOPNOTSUPP (or would not even
>> > exist if the driver has no support) and ethtool would say so.
>> 
>> (I know that the comments below only apply if "ethtool-way" is what's
>> decided)
>> 
>> Cool. Will remove the supported bit.
>
> Shall it move to the link_ksettings fixed supported list? So can be
> checked by the ethtool -k command. I understand that the hw features
> are encouraged listing in the ksettings.

Having it in link_ksettings might make sense, using something like
"frame-preemption: off [fixed]" to mean "not supported" sounds nice.

> The two MACs should all be initialized at driver size. And all frame queues should assigned to the express MAC by default. That looks as normal mode called preemption disable.
> Any frame queues assigned pass preemptable MAC could be called
> preemption enable.

If you mean to have frame-preemption enabled by default, I think it
should be a per-driver decision, and probably disabled by default, at
least in the begining: frame preemption might interact badly with other
features, jumbo frames and EEE come to mind.


Cheers,
--
Vinicius
