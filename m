From: Ken Cox <jkc@redhat.com>
Date: Tue, 14 Dec 2021 07:19:35 -0600
Subject: [Intel-wired-lan] [Patch 2/2] iavf: Prevent reset from being
 scheduled while adapter is being removed
In-Reply-To: <4ebe129aeecda496fcad40377903c14d9d0c2dec.camel@intel.com>
References: <20211208102153.669338-1-jkc@redhat.com>
 <20211208102153.669338-3-jkc@redhat.com>
 <4ebe129aeecda496fcad40377903c14d9d0c2dec.camel@intel.com>
Message-ID: <0db0aed4-94bf-4038-0dd7-3960ec1306bb@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



On 12/13/21 12:27, Nguyen, Anthony L wrote:
> On Wed, 2021-12-08 at 04:21 -0600, Ken Cox wrote:
>> If a reset gets scheduled while the adapter is being removed it can
>> cause a panic.
>>
>> The work_struct for the reset_task is contained in the iavf_adapter
>> structure.? iavf_remove() eventually frees the iavf_adapter structure
>> so if there is active work scheduled it can cause a panic.
>>
>> Signed-off-by: Ken Cox <jkc@redhat.com>
> 
> Like the other patch, this one isn't applying.
> 
> Thanks,
> Tony
> 
Sorry, I was in the wrong branch when I generated these patches.  Please 
disregard.  I will re-evaluate and resend if necessary.

