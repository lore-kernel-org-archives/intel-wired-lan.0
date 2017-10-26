From: Nambiar, Amritha <amritha.nambiar@intel.com>
Date: Thu, 26 Oct 2017 14:47:07 -0700
Subject: [Intel-wired-lan] [jkirsher/next-queue PATCH v4 6/6] i40e:
 Enable cloud filters via tc-flower
In-Reply-To: <28335085-cc51-85a5-d602-4ae9d1e1088c@oracle.com>
References: <150768099999.5320.1633617713417675266.stgit@anamdev.jf.intel.com>
 <150768148418.5320.6338243543224569414.stgit@anamdev.jf.intel.com>
 <86d2bf80-cf02-9cc0-291d-c00ff39d613b@oracle.com>
 <888ad716-75c7-f1c0-439a-58fdeb9a7234@intel.com>
 <28335085-cc51-85a5-d602-4ae9d1e1088c@oracle.com>
Message-ID: <27b531d3-39bf-2b08-1b0b-298689568315@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 10/26/2017 2:35 PM, Shannon Nelson wrote:
> On 10/26/2017 2:29 PM, Nambiar, Amritha wrote:
>> On 10/11/2017 4:30 PM, Shannon Nelson wrote:
>>> On 10/10/2017 5:24 PM, Amritha Nambiar wrote:
> 
> [...]
> 
>>>> +		/* For Geneve, the VNI should be placed in offset shifted by a
>>>> +		 * byte than the offset for the Tenant ID for rest of the
>>>
>>> This comment isn't quite clear - maybe s/than/then/ ?
>>
>> How about, "For Geneve, the VNI should begin at an offset shifted by a
>> byte compared to the offset normally used for the Tenant ID for other
>> tunnel types" ?
> 
> Or maybe "Due to hardware eccentricities, the VNI for Geneve is shifted 
> one more byte further than normally used for Tenant ID in other tunnel 
> types"

Will do. Thanks.

> 
> [...]
> 
>>>> +				dev_err(&pf->pdev->dev, "Bad src port mask 0x%04x\n",
>>>
>>> Consider using %pI4
>>
>> For ports, I'll keep the 0x%04x. I'll change to %pI4 for the IPv4
>> address masks.
> 
> Oh, right, that one's a port.
> 
> sln
> 
