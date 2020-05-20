From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Date: Wed, 20 May 2020 14:32:31 -0700
Subject: [Intel-wired-lan] [next-queue RFC 0/4] ethtool: Add support for
 frame preemption
In-Reply-To: <20200520125232.s3zrmlnesqjilcf6@soft-dev16>
References: <20200516012948.3173993-1-vinicius.gomes@intel.com>
 <158992799425.36166.17850279656312622646@twxiong-mobl.amr.corp.intel.com>
 <87y2pnmr83.fsf@intel.com> <20200520125232.s3zrmlnesqjilcf6@soft-dev16>
Message-ID: <87blmimgwg.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Joergen Andreasen <joergen.andreasen@microchip.com> writes:

>> So I thought I was better to let the driver decide what values are
>> acceptable.
>> 
>> This is a good question for people working with other hardware.
>> 
>
> I think it's most intuitive to use the values for AddFragSize as described in
> 802.3br (N = 0, 1, 2, 3).
> You will anyway have to use one of these values when you want to expose the
> requirements of your receiver through LLDP.
>

Thanks. Seems that keeping this value restricted to multiples of 64 is
the way to go. Will fix for the next version of the series.


Cheers,
-- 
Vinicius
