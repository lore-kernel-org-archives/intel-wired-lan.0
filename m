From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Date: Wed, 07 Mar 2018 14:24:04 -0800
Subject: [Intel-wired-lan] [next-queue PATCH v3 8/8] igb: Add support
 for adding offloaded clsflower filters
In-Reply-To: <20180307114831.16b1788b@cakuba.netronome.com>
References: <20180307012957.7052-1-vinicius.gomes@intel.com>
 <20180307012957.7052-9-vinicius.gomes@intel.com>
 <20180307114831.16b1788b@cakuba.netronome.com>
Message-ID: <87tvtrzfqz.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi,

Jakub Kicinski <kubakici@wp.pl> writes:

> On Tue,  6 Mar 2018 17:29:57 -0800, Vinicius Costa Gomes wrote:
>> This allows filters added by tc-flower and specifying MAC addresses,
>> Ethernet types, and the VLAN priority field, to be offloaded to the
>> controller.
>> 
>> This reuses most of the infrastructure used by ethtool, but clsflower
>> filters are kept in a separated list, so they are invisible to
>> ethtool.
>> 
>> Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
>
> LGTM, thanks!
>
>> +		NL_SET_ERR_MSG(extack,
>
> One nit: consider using NL_SET_ERR_MSG_MOD to prefix the message with
> driver name.

Sure thing. Will send a v4 with this shortly.


Cheers,
--
Vinicius
