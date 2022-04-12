From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Date: Mon, 11 Apr 2022 20:01:42 -0700
Subject: [Intel-wired-lan] [PATCH net-queue v1] igc: Fix suspending when
 PTM is active
In-Reply-To: <019c889a-35be-a443-38a0-113e094d68b4@molgen.mpg.de>
References: <20220405205437.29829-1-vinicius.gomes@intel.com>
 <019c889a-35be-a443-38a0-113e094d68b4@molgen.mpg.de>
Message-ID: <877d7vc8dl.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Paul Menzel <pmenzel@molgen.mpg.de> writes:

> Dear Vinicius,
>
>
> Thank you for your patch.
>
> Am 05.04.22 um 22:54 schrieb Vinicius Costa Gomes:
>> Some mainboard/CPU combinations have shown problems with
>> suspend/resume when PCIe PTM is enabled and active.
>
> Please give a concrete example of a mainboard/CPU combination with that 
> problem, and document exactly what the problem is (system hangs, when, 
> where, just no network device)?

Sure. Will add.

>
> Also, please use 75 characters per line in commit messages.
>

Will fix.

@Tony, I will send a v2.

>
> Acked-by: Paul Menzel <pmenzel@molgen.mpg.de>
>
>
> Kind regards,
>
> Paul

Thank you,
-- 
Vinicius
