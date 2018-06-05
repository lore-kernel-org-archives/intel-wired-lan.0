From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Tue, 5 Jun 2018 09:55:49 -0700
Subject: [Intel-wired-lan] [net-queue PATCH] ixgbe: check that ipsec is
 available on the chip
In-Reply-To: <87fad9bf-6708-4b1d-55c2-49e8d4cd952b@oracle.com>
References: <1528138710-31848-1-git-send-email-shannon.nelson@oracle.com>
 <CAD=hENe=mx_h1zqF1h2=jir8s64UhRfLKogZDu_jhfC3iz9BNw@mail.gmail.com>
 <e18490a9-1b97-d351-9f85-d8f0d35cc1fa@oracle.com>
 <CAD=hENc6JZYrGuN77T-NcwBMt0+jT0mB2M5ONTzrfpFT6ZX88w@mail.gmail.com>
 <87fad9bf-6708-4b1d-55c2-49e8d4cd952b@oracle.com>
Message-ID: <CAKgT0Ueh0a76GmHZUUf1uRFHwhz+EOT354_CF5BjC43EWOgyVw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, Jun 5, 2018 at 9:22 AM, Shannon Nelson
<shannon.nelson@oracle.com> wrote:
> On 6/5/2018 5:10 AM, zhuyj wrote:
>>
>>   In the mainline kernel source code, it seems that the above does not
>> exist. Do you use the latest ixgbe source code from e1000 maillist?
>> And can we use "ethtool -K" to enable/disable ipsec offload?
>
>
> I believe it is in Linux v4.15 and later.  Be sure to enable
> CONFIG_INET_ESP_OFFLOAD and CONFIG_INET6_ESP_OFFLOAD to enable all the IPsec
> offload features.
>
> Since the output shows "[fixed]", the user is not able to change it on the
> fly.
>
> sln

I'm pretty sure the "[fixed]" was due to a bug. Specifically we were
setting the bits in hw_enc_features instead of hw_features. I fixed
that in the patch set I submitted yesterday.

- Alex
