From: Neftin, Sasha <sasha.neftin@intel.com>
Date: Wed, 22 Jan 2020 08:28:41 +0200
Subject: [Intel-wired-lan] [PATCH v1] igc: Complete to commit Add basic
 skeleton for PTP
In-Reply-To: <87o8uw31zr.fsf@linux.intel.com>
References: <20200120063350.36467-1-sasha.neftin@intel.com>
 <87o8uw31zr.fsf@linux.intel.com>
Message-ID: <545eced6-a1ef-185d-41a5-3289cc045107@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 1/21/2020 23:59, Vinicius Costa Gomes wrote:
> Hi Sasha,
> 
> Sasha Neftin <sasha.neftin@intel.com> writes:
> 
>> commit 5f2958052c58 ("igc: Add basic skeleton for PTP")
>> Add ptp suspend method to the igc_shutdown.
> 
> I guess the commit message could use a bit more text, something like
> this:
> 
> "Commit 5f2958052c58 ("igc: Add basic skeleton for PTP") added basic
> support for PTP, what's missing is support for suspending. By cleaning
> the runtime storage for timestamp this avoids a possible invalid memory
> access when the system comes back from suspend."
Thanks Vinicius - I will extend the commit message in v2.
> 
> Apart from that, the code looks good.
> 
> Is this the only thing missing for suspend/resume to work? If so, that's
> cool :-)
> 
> 
> Cheers,
> --
> Vinicius
> 

