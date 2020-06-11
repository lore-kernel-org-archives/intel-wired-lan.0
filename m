From: Neftin, Sasha <sasha.neftin@intel.com>
Date: Thu, 11 Jun 2020 07:33:33 +0300
Subject: [Intel-wired-lan] [PATCH v2 1/1] igc: Remove unneeded check for
 copper media type
In-Reply-To: <159181443856.78170.15999671258648186100@camachog-mobl.amr.corp.intel.com>
References: <20200610124308.41422-1-sasha.neftin@intel.com>
 <159181443856.78170.15999671258648186100@camachog-mobl.amr.corp.intel.com>
Message-ID: <c9854869-5522-29ea-41c0-4306e9829f4f@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 6/10/2020 21:40, Andre Guedes wrote:
> Hi Sasha,
> 
>> PHY of the i225 device support only copper mode.
>> There is no point to check media type in the
>> igc_power_up_link() method.
> 
> A quick grep shows that we have many checks like this in the igc code. How
> about we extend this patch to remove all of them at once?
yes I know. we will do clean up per logic impact. For example, "force 
speed" mode not supported, need to clean up all logic, not only "copper 
media type".
> 
> Regards,
> 
> Andre
> 
Hello Andre,
Thanks,
Sasha

