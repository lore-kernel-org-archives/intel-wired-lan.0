From: =?unknown-8bit?q?Pawe=C5=82?= Staszewski <pstaszewski@itcare.pl>
Date: Mon, 23 Oct 2017 01:15:00 +0200
Subject: [Intel-wired-lan] [jkirsher/net-queue PATCH] i40e: Add
 programming descriptors to cleaned_count
In-Reply-To: <1508695307.4970.32.camel@cohaesio.com>
References: <20171022011222.12997.53593.stgit@localhost.localdomain>
 <1508695307.4970.32.camel@cohaesio.com>
Message-ID: <003ecf6b-bd50-51fa-79a7-eab2b100257b@itcare.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Yes can confirm that after adding patch:

[jkirsher/net-queue PATCH] i40e: Add programming descriptors to 
cleaned_count


There is no memleak.



W dniu 2017-10-22 o?20:01, Anders K. Pedersen | Cohaesio pisze:
> On l?r, 2017-10-21 at 18:12 -0700, Alexander Duyck wrote:
>> From: Alexander Duyck <alexander.h.duyck@intel.com>
>>
>> This patch updates the i40e driver to include programming descriptors
>> in
>> the cleaned_count. Without this change it becomes possible for us to
>> leak
>> memory as we don't trigger a large enough allocation when the time
>> comes to
>> allocate new buffers and we end up overwriting a number of rx_buffers
>> equal
>> to the number of programming descriptors we encountered.
>>
>> Fixes: 0e626ff7ccbf ("i40e: Fix support for flow director programming
>> status")
>> Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
> This patch solves the remaining memory leak we've seen, so
>
> Tested-by: Anders K. Pedersen <akp@cohaesio.com>
>
> Regards,
> Anders

