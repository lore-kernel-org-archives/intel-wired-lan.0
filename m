From: Tyler S <tylerjstachecki@gmail.com>
Date: Sun, 25 Apr 2021 19:09:39 -0400
Subject: [Intel-wired-lan] [PATCH net v2] igb: Fix XDP with PTP enabled
Message-ID: <CAMfj=-YEh1ZnLB8zye7i-5Y2S015n0qat+FQ6JW7bFKwBUHBPg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Thanks for this work; I was having trouble using XDP on my I354 NIC until this.

Hopefully I have not err'd backporting it to 5.10 -- but I'm seeing
jumbo frames dropped after applying this (though as previously
mentioned, non-skb/full driver XDP programs do now work).

Looking at the code, I'm not sure why that is.

- Tyler
