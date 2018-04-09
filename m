From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Date: Mon, 09 Apr 2018 10:36:46 -0700
Subject: [Intel-wired-lan] [next-queue PATCH v6 10/10] igb: Add support
 for adding offloaded clsflower filters
In-Reply-To: <309B89C4C689E141A5FF6A0C5FB2118B8C82598F@ORSMSX101.amr.corp.intel.com>
References: <20180329210751.11531-1-vinicius.gomes@intel.com>
 <20180329210751.11531-11-vinicius.gomes@intel.com>
 <309B89C4C689E141A5FF6A0C5FB2118B8C82598F@ORSMSX101.amr.corp.intel.com>
Message-ID: <87woxgjn81.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi,

"Brown, Aaron F" <aaron.f.brown@intel.com> writes:

>> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
>> Behalf Of Vinicius Costa Gomes
>> Sent: Thursday, March 29, 2018 2:08 PM
>> To: intel-wired-lan at lists.osuosl.org
>> Cc: netdev at vger.kernel.org; Sanchez-Palencia, Jesus <jesus.sanchez-
>> palencia at intel.com>
>> Subject: [Intel-wired-lan] [next-queue PATCH v6 10/10] igb: Add support for
>> adding offloaded clsflower filters
>> 
>> This allows filters added by tc-flower and specifying MAC addresses,
>> Ethernet types, and the VLAN priority field, to be offloaded to the
>> controller.
>
> Can I get a brief explanation for enabling this?  I'm currently happy
> with this patch series from a regression perspective, but am
> personally a bit, umm, challenged with tc in general but would like to
> run it through the paces a bit.  If it can be done in a one or two
> liner I think it would be a good addition to the patch description.


Of course, my bad for not adding those examples since the begining.



Cheers,
--
Vinicius
