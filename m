From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Date: Wed, 07 Mar 2018 16:10:38 -0800
Subject: [Intel-wired-lan] [next-queue PATCH v3 6/8] igb: Add MAC
 address support for ethtool nftuple filters
In-Reply-To: <309B89C4C689E141A5FF6A0C5FB2118B8C7FFA86@ORSMSX101.amr.corp.intel.com>
References: <20180307012957.7052-1-vinicius.gomes@intel.com>
 <20180307012957.7052-7-vinicius.gomes@intel.com>
 <309B89C4C689E141A5FF6A0C5FB2118B8C7FFA86@ORSMSX101.amr.corp.intel.com>
Message-ID: <871sgvzatd.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi,

"Brown, Aaron F" <aaron.f.brown@intel.com> writes:

>> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
>> Behalf Of Vinicius Costa Gomes
>> Sent: Tuesday, March 6, 2018 5:30 PM
>> To: intel-wired-lan at lists.osuosl.org
>> Cc: netdev at vger.kernel.org; Sanchez-Palencia, Jesus <jesus.sanchez-
>> palencia at intel.com>
>> Subject: [Intel-wired-lan] [next-queue PATCH v3 6/8] igb: Add MAC address
>> support for ethtool nftuple filters
>> 
>> This adds the capability of configuring the queue steering of arriving
>> packets based on their source and destination MAC addresses.
>> 
>> In practical terms this adds support for the following use cases,
>> characterized by these examples:
>> 
>> $ ethtool -N eth0 flow-type ether dst aa:aa:aa:aa:aa:aa action 0
>> (this will direct packets with destination address "aa:aa:aa:aa:aa:aa"
>> to the RX queue 0)
>> 
>> $ ethtool -N eth0 flow-type ether src 44:44:44:44:44:44 action 3
>> (this will direct packets with destination address "44:44:44:44:44:44"
>> to the RX queue 3)
>
> I assume this example should read "... source address"  rather than
> "...destination".

Ugh, yeah. Will be fixed on v4.


Thank you,
--
Vinicius
