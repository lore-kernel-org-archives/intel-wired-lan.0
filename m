From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Date: Fri, 29 Jan 2021 13:01:53 -0800
Subject: [Intel-wired-lan] [PATCH net-next v3 5/8] igc: Avoid TX Hangs
 because long cycles
In-Reply-To: <20210126000228.gpyh3rrp662wysit@skbuf>
References: <20210122224453.4161729-1-vinicius.gomes@intel.com>
 <20210122224453.4161729-6-vinicius.gomes@intel.com>
 <20210126000228.gpyh3rrp662wysit@skbuf>
Message-ID: <877dnvtq2m.fsf@vcostago-mobl2.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi,

Vladimir Oltean <vladimir.oltean@nxp.com> writes:

> On Fri, Jan 22, 2021 at 02:44:50PM -0800, Vinicius Costa Gomes wrote:
>> Avoid possible TX Hangs caused by using long Qbv cycles. In some
>> cases, using long cycles (more than 1 second) can cause transmissions
>> to be blocked for that time. As the TX Hang timeout is close to 1
>> second, we may need to reduce the cycle time to something more
>> reasonable: the value chosen is 1ms.
>> 
>> Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
>> ---
>
> Don't you want this patch to go to 'net' and be backported?

Will propose this patch to 'net'. Thanks.


Cheers,
-- 
Vinicius
