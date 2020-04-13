From: Waiman Long <longman@redhat.com>
Date: Mon, 13 Apr 2020 17:52:24 -0400
Subject: [Intel-wired-lan] [PATCH 2/2] crypto: Remove unnecessary
 memzero_explicit()
In-Reply-To: <efd6ceb1f182aa7364e9706422768a1c1335aee4.camel@perches.com>
References: <20200413211550.8307-1-longman@redhat.com>
 <20200413211550.8307-3-longman@redhat.com>
 <efd6ceb1f182aa7364e9706422768a1c1335aee4.camel@perches.com>
Message-ID: <7e13a94b-2e92-850f-33f7-0f42cfcd9009@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 4/13/20 5:31 PM, Joe Perches wrote:
> On Mon, 2020-04-13 at 17:15 -0400, Waiman Long wrote:
>> Since kfree_sensitive() will do an implicit memzero_explicit(), there
>> is no need to call memzero_explicit() before it. Eliminate those
>> memzero_explicit() and simplify the call sites.
> 2 bits of trivia:
>
>> diff --git a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-cipher.c b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-cipher.c
> []
>> @@ -391,10 +388,7 @@ int sun8i_ce_aes_setkey(struct crypto_skcipher *tfm, const u8 *key,
>>  		dev_dbg(ce->dev, "ERROR: Invalid keylen %u\n", keylen);
>>  		return -EINVAL;
>>  	}
>> -	if (op->key) {
>> -		memzero_explicit(op->key, op->keylen);
>> -		kfree(op->key);
>> -	}
>> +	kfree_sensitive(op->key);
>>  	op->keylen = keylen;
>>  	op->key = kmemdup(key, keylen, GFP_KERNEL | GFP_DMA);
>>  	if (!op->key)
> It might be a defect to set op->keylen before the kmemdup succeeds.
It could be. I can move it down after the op->key check.
>> @@ -416,10 +410,7 @@ int sun8i_ce_des3_setkey(struct crypto_skcipher *tfm, const u8 *key,
>>  	if (err)
>>  		return err;
>>  
>> -	if (op->key) {
>> -		memzero_explicit(op->key, op->keylen);
>> -		kfree(op->key);
>> -	}
>> +	free_sensitive(op->key, op->keylen);
> Why not kfree_sensitive(op->key) ?

Oh, it is a bug. I will send out v2 to fix that.

Thanks for spotting it.

Cheers,
Longman


>
>

